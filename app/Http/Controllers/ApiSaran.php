<?php

namespace App\Http\Controllers;

use App\Models\Saran;
use Illuminate\Http\Request;

class ApiSaran extends Controller
{
    public function add(Request $request){//ok
        $saran = Saran::create($request->all());
        return response()->json(["message"=>"add saran sukses"]);
    }
}
