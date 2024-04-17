<?php

namespace App\Http\Controllers;

use App\Models\Home;
use App\Models\Kategori;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class HomeController extends Controller
{
    public function get()
    {
        $produk = DB::table('products')->join('user_partners', 'products.id_user', '=', 'user_partners.id')
                        ->select('products.foto_produk','products.nama_produk','products.deskripsi','products.harga',
                                'user_partners.nomor_hp')
                        ->where('products.sold', 'no')
                        ->get();
        $kategori = Kategori::select('nama_kategori')
                            ->get();
        return view('home', compact('produk', 'kategori'));
    }
}
