<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class SubKategori extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $data = [
            //gadget
            ['nama_kategori' => 'Gadget', 'nama_subkategori'=>'Smartphone'],
            ['nama_kategori' => 'Gadget', 'nama_subkategori'=>'Laptop'],
            ['nama_kategori' => 'Gadget', 'nama_subkategori'=>'Tablet'],
            ['nama_kategori' => 'Gadget', 'nama_subkategori'=>'Komputer'],
            ['nama_kategori' => 'Gadget', 'nama_subkategori'=>'Lainnya'],
            //outfit
            ['nama_kategori' => 'Outfit', 'nama_subkategori'=>'Pakaian Anak'],
            ['nama_kategori' => 'Outfit', 'nama_subkategori'=>'Pakaian Pria'],
            ['nama_kategori' => 'Outfit', 'nama_subkategori'=>'Pakaian Wanita'],
            ['nama_kategori' => 'Outfit', 'nama_subkategori'=>'Sepatu'],
            ['nama_kategori' => 'Outfit', 'nama_subkategori'=>'Lainnya'],
            //kendaraan
            ['nama_kategori' => 'Kendaraan', 'nama_subkategori'=>'Sepeda'],
            ['nama_kategori' => 'Kendaraan', 'nama_subkategori'=>'Sepeda Motor'],
            ['nama_kategori' => 'Kendaraan', 'nama_subkategori'=>'Mobil'],
            ['nama_kategori' => 'Kendaraan', 'nama_subkategori'=>'Kendaraan Listrik'],
            ['nama_kategori' => 'Kendaraan', 'nama_subkategori'=>'Lainnya'],
            //furniture
            ['nama_kategori' => 'Furniture', 'nama_subkategori'=>'Sofa'],
            ['nama_kategori' => 'Furniture', 'nama_subkategori'=>'Meja'],
            ['nama_kategori' => 'Furniture', 'nama_subkategori'=>'Kursi'],
            ['nama_kategori' => 'Furniture', 'nama_subkategori'=>'Lemari'],
            ['nama_kategori' => 'Furniture', 'nama_subkategori'=>'Lainnya'],
            //hobi
            ['nama_kategori' => 'Hobi dan Mainan', 'nama_subkategori'=>'Mainan Anak'],
            ['nama_kategori' => 'Hobi dan Mainan', 'nama_subkategori'=>'Game'],
            ['nama_kategori' => 'Hobi dan Mainan', 'nama_subkategori'=>'Alat Pancing'],
            ['nama_kategori' => 'Hobi dan Mainan', 'nama_subkategori'=>'Peralatan Seni'],
            ['nama_kategori' => 'Hobi dan Mainan', 'nama_subkategori'=>'Lainnya'],
            //olahraga
            ['nama_kategori' => 'Olahraga', 'nama_subkategori'=>'Alat Olahraga'],
            ['nama_kategori' => 'Olahraga', 'nama_subkategori'=>'Alat Fitnes'],
            ['nama_kategori' => 'Olahraga', 'nama_subkategori'=>'Pakaian Olahraga'],
            ['nama_kategori' => 'Olahraga', 'nama_subkategori'=>'Sepatu Olahraga'],
            ['nama_kategori' => 'Olahraga', 'nama_subkategori'=>'Lainnya'],
            //rumah
            ['nama_kategori' => 'Rumah Tangga', 'nama_subkategori'=>'Perabotan'],
            ['nama_kategori' => 'Rumah Tangga', 'nama_subkategori'=>'Alat Kebersihan'],
            ['nama_kategori' => 'Rumah Tangga', 'nama_subkategori'=>'Mesin Cuci'],
            ['nama_kategori' => 'Rumah Tangga', 'nama_subkategori'=>'Blender'],
            ['nama_kategori' => 'Rumah Tangga', 'nama_subkategori'=>'Lainnya'],
            //elektronik
            ['nama_kategori' => 'Elektronik', 'nama_subkategori'=>'Televisi'],
            ['nama_kategori' => 'Elektronik', 'nama_subkategori'=>'Radio'],
            ['nama_kategori' => 'Elektronik', 'nama_subkategori'=>'Blu-ray Player'],
            ['nama_kategori' => 'Elektronik', 'nama_subkategori'=>'Kamera Digital'],
            ['nama_kategori' => 'Elektronik', 'nama_subkategori'=>'Lainnya'],
            //alat
            ['nama_kategori' => 'Alat Kerja', 'nama_subkategori'=>'Peralatan Bengkel'],
            ['nama_kategori' => 'Alat Kerja', 'nama_subkategori'=>'Mesin Bor'],
            ['nama_kategori' => 'Alat Kerja', 'nama_subkategori'=>'Peralatan Konstruksi'],
            ['nama_kategori' => 'Alat Kerja', 'nama_subkategori'=>'Keamanan Kerja'],
            ['nama_kategori' => 'Alat Kerja', 'nama_subkategori'=>'Lainnya'],
            //peliharaan
            ['nama_kategori' => 'Peliharaan', 'nama_subkategori'=>'Akuarium'],
            ['nama_kategori' => 'Peliharaan', 'nama_subkategori'=>'Kandang Burung'],
            ['nama_kategori' => 'Peliharaan', 'nama_subkategori'=>'Kandang Reptil'],
            ['nama_kategori' => 'Peliharaan', 'nama_subkategori'=>'Perlengkapan Kucing'],
            ['nama_kategori' => 'Peliharaan', 'nama_subkategori'=>'Lainnya'],
            //etc
            ['nama_kategori' => 'Lainnya', 'nama_subkategori'=>'Lainnya'],
        ];
        DB::table('sub_kategoris')->insert($data);
    }
}
