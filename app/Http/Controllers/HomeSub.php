<?php

namespace App\Http\Controllers;

use App\Models\Kategori;
use App\Models\SubKategori;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class HomeSub extends Controller
{
    public function get($nama_kategori,$nama_subkategori)
    {
        $kategori = Kategori::select('nama_kategori')
                            ->where('nama_kategori', $nama_kategori)
                            ->get();
        $subkategori = SubKategori::select('nama_subkategori')
                                    
                                    ->where('nama_subkategori', $nama_subkategori)
                                    ->get();
        $produk = DB::table('products')->join('user_partners', 'products.id_user', '=', 'user_partners.id')
                            ->select('products.foto_produk','products.nama_produk','products.deskripsi','products.harga',
                                    'user_partners.nomor_hp')
                            ->where('products.sub_kategori', $nama_subkategori)
                            ->where('products.sold', 'no')
                            ->get();
        return view('homesub', compact('kategori', 'subkategori', 'produk'));
    }
}
