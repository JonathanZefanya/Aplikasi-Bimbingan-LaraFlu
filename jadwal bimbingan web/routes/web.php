<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\GeneticController;
use App\Http\Middleware\AuthMiddleware;
use Illuminate\Support\Facades\Route;

Route::get('/', [AuthController::class, 'login']);
Route::post('/', [AuthController::class, 'login']);
Route::get('/logout', [AuthController::class, 'logout']);
Route::get('/contoh-metode-genetic', [GeneticController::class, 'index']);
Route::get('/cron-metode-genetic', [GeneticController::class, 'cakaran']);
Route::get('/cek-notifikasi', [GeneticController::class, 'testNotification']);


Route::middleware([AuthMiddleware::class])->group(function() {
    Route::get('/pengguna', [DashboardController::class, 'pengguna']);
    Route::get('/mahasiswa', [DashboardController::class, 'mahasiswa']);
    Route::get('/dosen', [DashboardController::class, 'dosen']);
    Route::get('/bimbingan', [DashboardController::class, 'bimbingan']);

    Route::post('/ubah-pengguna', [DashboardController::class, 'editPengguna']);
    Route::get('/hapus-pengguna/{id}', [DashboardController::class, 'deletePengguna']);
    Route::post('/tambah-dosen', [DashboardController::class, 'addDosen']);
    Route::post('/ubah-dosen', [DashboardController::class, 'editDosen']);
    Route::get('/hapus-dosen/{id}', [DashboardController::class, 'deleteDosen']);
    Route::post('/tambah-mahasiswa', [DashboardController::class, 'addMahasiswa']);
    Route::post('/ubah-mahasiswa', [DashboardController::class, 'editMahasiswa']);
    Route::get('/hapus-mahasiswa/{id}', [DashboardController::class, 'deleteMahasiswa']);
    Route::post('/tambah-bimbingan', [DashboardController::class, 'addBimbingan']);
    Route::post('/ubah-bimbingan', [DashboardController::class, 'editBimbingan']);
    Route::get('/hapus-bimbingan/{id}', [DashboardController::class, 'deleteBimbingan']);
});