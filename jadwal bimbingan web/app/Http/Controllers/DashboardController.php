<?php

namespace App\Http\Controllers;

use App\Models\Bimbingan;
use App\Models\Dosen;
use App\Models\JadwalDosen;
use App\Models\Mahasiswa;
use App\Models\RiwayatBimbingan;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class DashboardController extends Controller
{
    public function pengguna() {
        $users = User::with(['mahasiswa', 'dosen'])->where('level', '!=', 'admin')->get();
        return view('dashboard.pengguna', ['users' => $users]);
    }

    public function editPengguna(Request $request) {
        $users = User::find($request->id);
        
        $users->username = $request->username;

        if(isset($request->password)) {
            $users->password = Hash::make($request->password);
        }

        $users->save();
        return redirect()->back()->with('success', 'Berhasil mengubah data ');
    }

    

    public function deletePengguna($id) {
        $users = User::find($id);

        if($users->level == 'dosen') {
            $dosen = Dosen::where('user_id', $id)->first();
            if($dosen != null) {
                $dosen->delete();
            }
        } elseif($users->level == 'mahasiswa') {
            $mahasiswa = Mahasiswa::where('user_id', $id)->first();
            if($mahasiswa != null) {
                $mahasiswa->delete();
            }
        }

        $users->delete();
        return redirect()->back()->with('error', 'Berhasil menghapus data ');
    }

    public function dosen() {
        $dosens = Dosen::with('user')->get();

        return view('dashboard.dosen', ['dosens' => $dosens]);
    }

    public function addDosen(Request $request) {
        $user = new User();
        $user->username = $request->username;
        $user->password = Hash::make($request->password);
        $user->level = 'dosen';
        $user->save();

        $dosen = new Dosen();
        $dosen->user_id = $user->user_id;
        $dosen->dosen_nama = $request->dosen_nama;
        $dosen->dosen_batas_bimbingan = $request->dosen_batas_bimbingan;
        $dosen->save();
        return redirect()->back()->with('success', 'Berhasil menambah data ');
    }

    public function editDosen(Request $request) {
        $dosen = Dosen::find($request->id);
        $dosen->dosen_nama = $request->dosen_nama;
        $dosen->dosen_batas_bimbingan = $request->dosen_batas_bimbingan;
        $dosen->save();
        return redirect()->back()->with('success', 'Berhasil mengubah data ');
    }
    
    public function deleteDosen($id) {
        $dosen = Dosen::find($id);
        $user = User::find($dosen->user_id);
        Bimbingan::where('dosen_id', $id)->delete();
        RiwayatBimbingan::where('dosen_id', $id)->delete();
        JadwalDosen::where('dosen_id', $id)->delete();
        $user->delete();
        $dosen->delete();
        return redirect()->back()->with('error', 'Berhasil menghapus data ');
    }
    public function mahasiswa() {
        $mahasiswas = Mahasiswa::with('user')->get();
        return view('dashboard.mahasiswa', ['mahasiswas' => $mahasiswas]);
    }

    public function addMahasiswa(Request $request) {
        $user = new User();
        $user->username = $request->username;
        $user->password = Hash::make($request->password);
        $user->level = 'mahasiswa';
        $user->save();

        $mahasiswa = new Mahasiswa();
        $mahasiswa->user_id = $user->user_id;
        $mahasiswa->mahasiswa_nama = $request->mahasiswa_nama;
        $mahasiswa->mahasiswa_total_bimbingan = 0;
        $mahasiswa->mahasiswa_status_bimbingan = false;
        $mahasiswa->save();
        return redirect()->back()->with('success', 'Berhasil menambah data ');
    }

    public function editMahasiswa(Request $request) {
        $mahasiswa = Mahasiswa::find($request->id);
        $mahasiswa->mahasiswa_nama = $request->mahasiswa_nama;
        $mahasiswa->save();
        return redirect()->back()->with('success', 'Berhasil mengubah data ');
    }
    public function deleteMahasiswa($id) {
        $mahasiswa = Mahasiswa::find($id);
        $user = User::find($mahasiswa->user_id);
        Bimbingan::where('mahasiswa_id', $id)->delete();
        RiwayatBimbingan::where('mahasiswa_id', $id)->delete();
        $user->delete();
        $mahasiswa->delete();
        return redirect()->back()->with('error', 'Berhasil menghapus data ');
    }

    public function bimbingan() {
        $dosens = Dosen::all();
        $mahasiswas = Mahasiswa::all();
        $bimbingans = Bimbingan::with(['dosen', 'mahasiswa'])->get();
        return view('dashboard.bimbingan', ['bimbingans' => $bimbingans, 'dosens' => $dosens, 'mahasiswas' => $mahasiswas]);
    }

    public function addBimbingan(Request $request) {
        $bimbinganCheck = Bimbingan::where(['dosen_id' => $request->dosen_id, 'mahasiswa_id' => $request->mahasiswa_id, ])->first();
        if($bimbinganCheck) {
            return redirect()->back()->with('error', 'Bimbingan dengan data tersebut telah ada sebelumnya ');
        }
        $bimbingan = new Bimbingan();
        $bimbingan->dosen_id = $request->dosen_id;
        $bimbingan->mahasiswa_id = $request->mahasiswa_id;
        $bimbingan->save();
        return redirect()->back()->with('success', 'Berhasil menambah data ');
    }

    public function editBimbingan(Request $request) {
        $bimbinganCheck = Bimbingan::where(['dosen_id' => $request->dosen_id, 'mahasiswa_id' => $request->mahasiswa_id, ])->first();
        if($bimbinganCheck) {
            return redirect()->back()->with('error', 'Bimbingan dengan data tersebut telah ada sebelumnya ');
        }
        $bimbingan = Bimbingan::find($request->id);
        $bimbingan->dosen_id = $request->dosen_id;
        $bimbingan->mahasiswa_id = $request->mahasiswa_id;
        $bimbingan->save();
        return redirect()->back()->with('success', 'Berhasil mengubah data ');
    }

    public function deleteBimbingan($id) {
        $bimbingan = Bimbingan::find($id);
        $bimbingan->delete();
        return redirect()->back()->with('error', 'Berhasil menghapus data ');
    }
}
