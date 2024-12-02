<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;

class Mahasiswa extends Model
{
    use HasFactory;
    protected $table = 'mahasiswas';
    public $timestamps = false;
    protected $primaryKey = 'mahasiswa_id';
    protected $keyType = 'string';
    protected $fillable = [
        'user_id',
        'mahasiswa_nama',
        'mahasiswa_start_bimbingan',
        'mahasiswa_end_bimbingan',
        'mahasiswa_total_bimbingan',
        'mahasiswa_status_bimbingan',
    ];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'user_id');
    }
    public function bimbingan(): HasMany {
        return $this->hasMany(Mahasiswa::class, 'mahasiswa_id');
    }
    
    public function riwayat_bimbingan(): HasMany {
        return $this->hasMany(Mahasiswa::class, 'mahasiswa_id');
    }
}
