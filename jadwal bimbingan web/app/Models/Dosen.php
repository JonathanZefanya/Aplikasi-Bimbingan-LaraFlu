<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;

class Dosen extends Model
{
    use HasFactory;
    protected $table = 'dosens';
    public $timestamps = false;
    protected $primaryKey = 'dosen_id';
    protected $keyType = 'string';
    protected $fillable = [
        'user_id',
        'dosen_nama',
        'dosen_batas_bimbingan',
    ];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function bimbingan(): HasMany {
        return $this->hasMany(Bimbingan::class, 'dosen_id');
    }

    public function riwayat_bimbingan(): HasMany {
        return $this->hasMany(Mahasiswa::class, 'dosen_id');
    }
}
