<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('users')->insert([
            [
                'username' => 'admin',
                'password' => Hash::make('password'),
                'level' => 'admin',
                'token' => null,
            ],
            [
                'username' => 'dosen',
                'password' => Hash::make('password'),
                'level' => 'dosen',
                'token' => null,
            ],
            [
                'username' => 'mahasiswa',
                'password' => Hash::make('password'),
                'level' => 'mahasiswa',
                'token' => null,
            ],
        ]);
    }
}
