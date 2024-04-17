<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class Kategori extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $data = [
            ['nama_kategori' => 'Gadget', 'foto'=>'Gadget.png'],
            ['nama_kategori' => 'Outfit', 'foto'=>'Outfit.png'],
            ['nama_kategori' => 'Kendaraan', 'foto'=>'Kendaraan.png'],
            ['nama_kategori' => 'Furniture', 'foto'=>'Furniture.png'],
            ['nama_kategori' => 'Hobi dan Mainan', 'foto'=>'Hobi dan Mainan.png'],
            ['nama_kategori' => 'Olahraga', 'foto'=>'Olahraga.png'],
            ['nama_kategori' => 'Rumah Tangga', 'foto'=>'Rumah Tangga.png'],
            ['nama_kategori' => 'Elektronik', 'foto'=>'Elektronik.png'],
            ['nama_kategori' => 'Alat Kerja', 'foto'=>'Alat Kerja.png'],
            ['nama_kategori' => 'Peliharaan', 'foto'=>'Peliharaan.png'],
            ['nama_kategori' => 'Lainnya', 'foto'=>'Lainnya.png'],
        ];
        DB::table('kategoris')->insert($data);
    }
}
