<?php

namespace App\Http\Controllers;

use App\Models\Kategori;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ApiKategori extends Controller
{
    public function getKategori()//ok
    {
        $kategori = Kategori::OrderBy('nama_kategori', 'ASC')
                                ->select('nama_kategori', 'foto')
                                ->get();
        return response()->json(['message'=>'kategori', 'data'=>$kategori]);
    }
}
