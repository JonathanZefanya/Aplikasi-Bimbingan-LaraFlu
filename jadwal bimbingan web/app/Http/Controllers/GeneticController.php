<?php

namespace App\Http\Controllers;

use App\Models\Bimbingan;
use App\Models\Dosen;
use App\Models\JadwalDosen;
use App\Models\Mahasiswa;
use App\Models\RiwayatBimbingan;
use App\Services\FirebaseMessagingService;
use Illuminate\Http\Request;

class GeneticController extends Controller
{
    protected $firebaseMessagingService;
    private $mahasiswas;

    public function __construct(FirebaseMessagingService $firebaseMessagingService)
    {
        $this->mahasiswas = Mahasiswa::take(10)->get();
        $this->firebaseMessagingService = $firebaseMessagingService;
    }

    public function index()
    {
        $dosen = Dosen::first(); // Ambil dosen pertama (asumsi hanya satu dosen)

        // Algoritma Genetik untuk memilih 5 mahasiswa terbaik
        $selectedStudents = $this->geneticAlgorithm($dosen, $this->mahasiswas);

        // dd($selectedStudents);
        return view('dashboard.genetic', compact('selectedStudents', 'dosen'));
    }

    public function cakaran()
    {
        $dosens = Dosen::with(['bimbingan.mahasiswa', 'user'])->get();

        foreach ($dosens as $dosen) {
            // PENCATATAN DOSEN & MAHASISWA YANG AKTIF BIMBINGAN
            $dataDosen = $dosen;
            $arrMahasiswa = [];

            foreach ($dosen->bimbingan as $bimbingan) {
                $mahasiswa = $bimbingan->mahasiswa;

                if ($mahasiswa->mahasiswa_status_bimbingan) {
                    array_push($arrMahasiswa, $mahasiswa);
                }
            }

            // MENCATAT MAHASISWA YANG JADWAL BIMBINGANNYA SESUAI DENGAN DOSEN
            $jadwals = JadwalDosen::where('dosen_id', $dataDosen->dosen_id)->get();
            $filterKandidat = [];

            foreach ($jadwals as $jadwal) {
                if (!$jadwal->is_processed) {
                    foreach ($arrMahasiswa as $mahasiswa) {
                        $mahasiswaStartDate = new \DateTime($mahasiswa->mahasiswa_start_bimbingan);
                        $mahasiswaEndDate = new \DateTime($mahasiswa->mahasiswa_end_bimbingan);
                        $mahasiswaEndDate->modify('+1 day');

                        $jadwalStartDate = new \DateTime($jadwal->dosen_tanggal_dari);
                        $jadwalEndDate = new \DateTime($jadwal->dosen_tanggal_sampai);

                        // LOGIC HERE: Cek apakah tanggal bimbingan mahasiswa berada dalam rentang tanggal jadwal dosen
                        if ($mahasiswaStartDate <= $jadwalEndDate && $mahasiswaEndDate >= $jadwalStartDate) {
                            if (!isset($filterKandidat[$jadwal->jadwal_dosen_id])) {
                                $filterKandidat[$jadwal->jadwal_dosen_id] = [];
                            }

                            array_push($filterKandidat[$jadwal->jadwal_dosen_id], $mahasiswa->mahasiswa_id);
                        }
                    }
                }
            }

            $selectedStudent = null;

            foreach ($filterKandidat as $keyFilter => $valueFilter) {
                $mahasiswaIds = array_values($valueFilter);
                $samples = Mahasiswa::whereIn('mahasiswa_id', $mahasiswaIds)->get();

                if (count($samples) < $dataDosen->dosen_batas_bimbingan) {
                    $dataDosen->dosen_batas_bimbingan = count($samples);
                }

                $selectedStudents = $this->processGeneticAlgorithm($dataDosen, $samples);

                // LOGIKA PENGKABARAN UNTUK DOSEN 
                if ($dataDosen->user->token != null) {
                    $title = 'Bimbingan';
                    $body = 'Peserta Bimbingan anda telah keluar, Buka aplikasi untuk melihat';
                    $token = $dataDosen->user->token;
        
                    $this->firebaseMessagingService->sendNotificationToToken($title, $body, $token);
                }
        
                // LOGIKA UPDATE DATA UNTUK MAHASISWA YANG TERPILIH
                foreach ($selectedStudents as $selectedStudent) {
                    $selectedStudent->mahasiswa_total_bimbingan += 1;
                    $selectedStudent->save();
        
                    $jadwalDosen = JadwalDosen::find($keyFilter);
                    $jadwalDosen->is_processed = true;
                    $jadwalDosen->save();
        
                    $riwayatBimbingan = new RiwayatBimbingan();
                    $riwayatBimbingan->jadwal_dosen_id = $keyFilter;
                    $riwayatBimbingan->mahasiswa_id = $selectedStudent->mahasiswa_id;
                    $riwayatBimbingan->dosen_id = $dataDosen->dosen_id;
                    $riwayatBimbingan->tanggal = $jadwalDosen->dosen_tanggal_dari;
                    $riwayatBimbingan->save();
        
                    // LOGIKA PENGKABARAN UNTUK MAHASISWA
                    if ($selectedStudent->user->token != null) {
                        $title = 'Bimbingan Baru';
                        $body = 'Jadwal Bimbingan terbaru telah keluar! Buka aplikasi untuk memeriksa';
                        $token = $selectedStudent->user->token;
        
                        $this->firebaseMessagingService->sendNotificationToToken($title, $body, $token);
                    }
                }
            }
        }
    }

    public function testNotification() {
        $dataDosen = Dosen::with('user')->where('dosen_id', 1)->first();
        if ($dataDosen->user->token != null) {
            $title = 'Bimbingan';
            $body = 'Peserta Bimbingan anda telah keluar, Buka aplikasi untuk mencoba';
            $token = $dataDosen->user->token;

            $this->firebaseMessagingService->sendNotificationToToken($title, $body, $token);
        }
    }

    private function fitness($solution, $preferences)
    {
        $score = 0;
        foreach ($solution as $student) {
            $score -= $preferences[$student];
        }
        return $score;
    }

    private function generatePopulation($dosen, $students, $populationSize)
    {
        $population = [];
        for ($i = 0; $i < $populationSize; $i++) {
            // Memilih 5 mahasiswa secara acak dari populasi
            $individual = $students->random($dosen->dosen_batas_bimbingan)->pluck('mahasiswa_id')->toArray();
            $population[] = $individual;
        }
        return $population;
    }

    private function select($population, $preferences)
    {
        usort($population, function ($a, $b) use ($preferences) {
            return $this->fitness($b, $preferences) <=> $this->fitness($a, $preferences);
        });
        return $population[0]; // Mengambil individu terbaik (5 mahasiswa terbaik)
    }

    private function processGeneticAlgorithm($dosen, $students)
    {
        $preferences = $students->pluck('mahasiswa_total_bimbingan', 'mahasiswa_id')->toArray();
        $populationSize = 20; // Ukuran populasi
        $generations = 50; // Jumlah generasi
        $population = $this->generatePopulation($dosen, $students, $populationSize);

        for ($i = 0; $i < $generations; $i++) {
            $population = $this->select($population, $preferences);

            // Memilih 5 mahasiswa terbaik dari populasi
            $selectedStudentIds = $population;

            // Memastikan hanya ada 5 mahasiswa yang terpilih
            if (count($selectedStudentIds) == $dosen->dosen_batas_bimbingan) {
                return Mahasiswa::with('user')->whereIn('mahasiswa_id', $selectedStudentIds)->get();
            }
        }

        // Jika tidak ditemukan solusi yang tepat, kembalikan yang terbaik pada saat terakhir
        return Mahasiswa::with('user')->whereIn('mahasiswa_id', $population[0])->take($dosen->dosen_batas_bimbingan)->get();
    }

    private function geneticAlgorithm($dosen, $students)
    {
        $preferences = $students->pluck('mahasiswa_total_bimbingan', 'mahasiswa_id')->toArray();
        $populationSize = 20; // Ukuran populasi
        $generations = 50; // Jumlah generasi
        $population = $this->generatePopulation($dosen, $students, $populationSize);

        for ($i = 0; $i < $generations; $i++) {
            $population = $this->select($population, $preferences);

            // Memilih 5 mahasiswa terbaik dari populasi
            $selectedStudentIds = $population;

            // Memastikan hanya ada 5 mahasiswa yang terpilih
            if (count($selectedStudentIds) == $dosen->dosen_batas_bimbingan) {
                return Mahasiswa::whereIn('mahasiswa_id', $selectedStudentIds)->get();
            }
        }

        // Jika tidak ditemukan solusi yang tepat, kembalikan yang terbaik pada saat terakhir
        return Mahasiswa::whereIn('mahasiswa_id', $population[0])->take($dosen->dosen_batas_bimbingan)->get();
    }
}
