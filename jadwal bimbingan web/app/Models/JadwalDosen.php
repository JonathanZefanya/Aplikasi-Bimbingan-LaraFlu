<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class JadwalDosen extends Model
{
    use HasFactory;
    protected $table = 'jadwal_dosens';
    public $timestamps = false;
    protected $primaryKey = 'jadwal_dosen_id';
    protected $keyType = 'string';
    protected $fillable = [
        'dosen_id',
        'dosen_tanggal_dari',
        'dosen_tanggal_selesai',
        'is_processed',
    ];

    public function riwayat_bimbingan(): HasMany {
        return $this->hasMany(RiwayatBimbingan::class, 'jadwal_dosen_id');
    }
}
