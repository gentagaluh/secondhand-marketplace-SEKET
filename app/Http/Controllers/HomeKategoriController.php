<?php

namespace App\Http\Controllers;

use App\Models\Kategori;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class HomeKategoriController extends Controller
{
    public function get($nama_kategori)
    {
        $kategori = Kategori::select('nama_kategori')
                            ->where('nama_kategori', $nama_kategori)
                            ->get();
        $subkategori = DB::table('sub_kategoris')->join('kategoris', 'sub_kategoris.nama_kategori', '=', 'kategoris.nama_kategori')
                            ->select('sub_kategoris.nama_subkategori')
                            ->where('kategoris.nama_kategori', $nama_kategori)
                            ->get();
        $produk = DB::table('products')->join('user_partners', 'products.id_user', '=', 'user_partners.id')
                            ->select('products.foto_produk','products.nama_produk','products.deskripsi','products.harga',
                                    'user_partners.nomor_hp')
                            ->where('products.kategori', $nama_kategori)
                            ->where('products.sold', 'no')
                            ->get();
        return view('homekategori', compact('kategori', 'subkategori', 'produk'));
    }
}
