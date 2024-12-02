<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class RiwayatBimbingan extends Model
{
    use HasFactory;
    protected $table = 'riwayat_bimbingans';
    public $timestamps = false;
    protected $primaryKey = 'riwayat_bimbingan_id';
    protected $keyType = 'string';
    protected $fillable = [
        'jadwal_dosen_id',
        'mahasiswa_id',
        'dosen_id',
        'tanggal',
    ];
    
    public function dosen(): BelongsTo {
        return $this->belongsTo(Dosen::class, 'dosen_id');
    }
    
    public function mahasiswa(): BelongsTo {
        return $this->belongsTo(Mahasiswa::class, 'mahasiswa_id');
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(JadwalDosen::class, 'jadwal_dosen_id');
    }
}
