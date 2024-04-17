<?php

namespace App\Http\Controllers;

use App\Models\SubKategori;
use Illuminate\Http\Request;

class ApiSubKategori extends Controller
{
    public function getByKategori($kategori)//ok
    {
        $subkategori = SubKategori::where('nama_kategori', $kategori)
                        ->select('nama_subkategori')
                        ->get();
        return response()->json(['message'=>'subkategori', 'data'=>$subkategori]);
    }
}
