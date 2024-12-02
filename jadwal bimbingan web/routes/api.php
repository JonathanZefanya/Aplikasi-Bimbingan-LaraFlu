<?php

use App\Http\Controllers\ApiController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::post('/login', [ApiController::class, 'login']);
Route::post('/logout', [ApiController::class, 'logout']);

Route::post('/mahasiswa-dashboard', [ApiController::class, 'mahasiswaDashboard']);
Route::post('/update-date-mahasiswa', [ApiController::class, 'updateDateMahasiswa']);
Route::post('/off-status-bimbingan', [ApiController::class, 'offStatusBimbingan']);
Route::post('/on-status-bimbingan', [ApiController::class, 'onStatusBimbingan']);
Route::post('/riwayat-bimbingan', [ApiController::class, 'riwayatBimbingan']);

Route::post('/dosen-dashboard', [ApiController::class, 'dosenDashboard']);
Route::post('/dosen-daftar-mahasiswa', [ApiController::class, 'dosenDaftarMahasiswa']);
Route::post('/riwayat-bimbingan-dosen', [ApiController::class, 'riwayatBimbinganDosen']);
Route::post('/daftar-bimbingan-dosen', [ApiController::class, 'daftarBimbinganDosen']);
Route::post('/add-date-dosen', [ApiController::class, 'addDateDosen']);
Route::post('/edit-date-dosen', [ApiController::class, 'editDateDosen']);
Route::post('/delete-date-dosen', [ApiController::class, 'deleteDateDosen']);
