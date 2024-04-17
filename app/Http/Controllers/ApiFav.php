<?php

namespace App\Http\Controllers;

use App\Models\Fav;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ApiFav extends Controller
{
    public function add(Request $request)//ok
    {
        Fav::create($request->all());
        return response()->json('add favorit sukses');
    }

    public function delete($id_buyer, $id_produk)//ok
    {
        Fav::where('id_buyer', $id_buyer)
                ->where('id_produk', $id_produk)
                ->delete();
        return response()->json('delete favorit sukses');
    }
}
