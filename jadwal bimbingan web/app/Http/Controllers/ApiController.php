<?php

namespace App\Http\Controllers;

use App\Http\Resources\ApiResource;
use App\Models\Bimbingan;
use App\Models\Dosen;
use App\Models\JadwalDosen;
use App\Models\Mahasiswa;
use App\Models\RiwayatBimbingan;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ApiController extends Controller
{
    public function login(Request $request) {
        if($request->method() == 'POST') {
            $user = User::where('username', $request->username)->first();
            if(Auth::attempt(['username' => $request->username, 'password' => $request->password])) {
                if($user->level == 'mahasiswa' || $user->level == 'dosen') {
                    $user->token = $request->token;
                    $user->save();
                    
                    return new ApiResource(true, 'success', $user);
                }else {
                    return new ApiResource(false, 'failed', null);
                }
            } else {
                return new ApiResource(false, 'failed', null);
            }
        } else {
            abort(505);
        }
    }

    public function logout(Request $request) {
        $user = User::where('username', $request->username)->first();
        $user->token = null;
        $user->save();
        return new ApiResource(true, 'success', $user);
    }

    public function mahasiswaDashboard(Request $request) {
        $user = User::with('mahasiswa')->where('username', $request->id)->first();
        return new ApiResource(true, 'success', $user);
    }

    public function updateDateMahasiswa(Request $request) {
        $user = User::with('mahasiswa')->where('username', $request->username)->first();
        $mahasiswa = Mahasiswa::where('user_id', $user->user_id)->first();
        $mahasiswa->mahasiswa_start_bimbingan = $request->start;
        $mahasiswa->mahasiswa_end_bimbingan = $request->end;
        $mahasiswa->save();
        return new ApiResource(true, 'success', $mahasiswa);
    }

    public function offStatusBimbingan(Request $request) {
        $user = User::with('mahasiswa')->where('username', $request->username)->first();
        $mahasiswa = Mahasiswa::where('user_id', $user->user_id)->first();
        $mahasiswa->mahasiswa_status_bimbingan = false;
        $mahasiswa->mahasiswa_start_bimbingan = null;
        $mahasiswa->mahasiswa_end_bimbingan = null;
        $mahasiswa->save();
        return new ApiResource(true, 'success', $mahasiswa);
    }

    public function onStatusBimbingan(Request $request) {
        $user = User::with('mahasiswa')->where('username', $request->username)->first();
        $mahasiswa = Mahasiswa::where('user_id', $user->user_id)->first();
        $mahasiswa->mahasiswa_status_bimbingan = true;
        $mahasiswa->save();
        return new ApiResource(true, 'success', $mahasiswa);
    }

    public function riwayatBimbingan(Request $request) {
        $user = User::with('mahasiswa')->where('username', $request->username)->first();
        $mahasiswa = Mahasiswa::where('user_id', $user->user_id)->first();
        $riwayatBimbingan = RiwayatBimbingan::with('dosen')->where('mahasiswa_id', $mahasiswa->mahasiswa_id)->get();
        return new ApiResource(true, 'success', $riwayatBimbingan);
    }

    public function dosenDashboard(Request $request) {
        $user = User::with('dosen')->where('username', $request->id)->first();
        return new ApiResource(true, 'success', $user);
    }

    public function dosenDaftarMahasiswa(Request $request) {
        $user = User::with('dosen')->where('username', $request->username)->first();
        $bimbingan = Bimbingan::with('mahasiswa')->where('dosen_id', $user->dosen->dosen_id)->get();
        return new ApiResource(true, 'success', $bimbingan);
    }

    public function riwayatBimbinganDosen(Request $request) {
        $user = User::with('dosen')->where('username', $request->username)->first();
        $dosen = Dosen::where('user_id', $user->user_id)->first();
        $riwayatBimbingan = RiwayatBimbingan::with('mahasiswa')->where('dosen_id', $dosen->dosen_id)->get();
        return new ApiResource(true, 'success', $riwayatBimbingan);
    }

    public function daftarBimbinganDosen(Request $request) {
        $user = User::with('dosen')->where('username', $request->username)->first();
        $dosen = Dosen::where('user_id', $user->user_id)->first();
        $jadwal = JadwalDosen::with('riwayat_bimbingan.mahasiswa')->where('dosen_id', $dosen->dosen_id)->get();
        return new ApiResource(true, 'success', $jadwal);
    }

    public function addDateDosen(Request $request) {
        $user = User::with('dosen')->where('username', $request->username)->first();
        $dosen = Dosen::where('user_id', $user->user_id)->first();
        $jadwal = new JadwalDosen();
        
        $jadwalCheck = JadwalDosen::where('dosen_tanggal_dari', $request->start)->first();

        if($jadwalCheck != null) {
            return new ApiResource(true, 'success', $jadwal);
        }

        $jadwal->dosen_id = $dosen->dosen_id;
        $jadwal->dosen_tanggal_dari = $request->start;
        $jadwal->dosen_tanggal_selesai = $request->end;
        $jadwal->save();
        
    }

    public function editDateDosen(Request $request) {
        $jadwal = JadwalDosen::find($request->id);

        $jadwalCheck = JadwalDosen::where('dosen_tanggal_dari', $request->start)->where('jadwal_dosen_id', '!=', $request->id)->first();

        if($jadwalCheck != null) {
            return new ApiResource(true, 'success', $jadwal);
        }

        $jadwal->dosen_tanggal_dari = $request->start;
        $jadwal->dosen_tanggal_selesai = $request->end;
        $jadwal->save();
        
        return new ApiResource(true, 'success', $jadwal);
    }

    public function deleteDateDosen(Request $request) {
        $jadwal = JadwalDosen::find($request->id);
        $jadwal->delete();
        
        return new ApiResource(true, 'success', null);

    }

    public function markScheduleAsDone(Request $request) {
        $riwayatBimbingan = RiwayatBimbingan::find($request->id);
        $riwayatBimbingan->riwayat_bimbingan_status = true;
        $riwayatBimbingan->save();
        return new ApiResource(true, 'success', $riwayatBimbingan);
    }

    public function addMahasiswaDosen(Request $request) {
        $user = User::with('dosen')->where('username', $request->username)->first();
        $dosen = Dosen::where('user_id', $user->user_id)->first();
        $mahasiswa = Mahasiswa::where('mahasiswa_nim', $request->nim)->first();
        $bimbingan = new Bimbingan();
        $bimbingan->dosen_id = $dosen->dosen_id;
        $bimbingan->mahasiswa_id = $mahasiswa->mahasiswa_id;
        $bimbingan->save();
        return new ApiResource(true, 'success', $bimbingan);
    }
}
