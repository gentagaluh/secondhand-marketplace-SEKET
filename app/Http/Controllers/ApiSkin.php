<?php

namespace App\Http\Controllers;

use App\Models\Skin;
use Illuminate\Http\Request;

class ApiSkin extends Controller
{
    public function getSkinById($id_user)//ok
    {
        $skin = Skin::where('id_user', $id_user)
                        ->select('total','skin', 'pelanggaran')
                        ->get();
        return response()->json(['message'=>'skin', 'data'=>$skin]);
    }
    public function add(Request $request)//ok
    {
        Skin::create($request->all());
        return response()->json('add skin sukses');
    }

    public function min(Request $request, $id_user)//ok
    {
        $skinawal = Skin::where('id_user', $id_user)
                    ->first();
        $min = $request->input('min');
        $skin = $skinawal->skin - $min;
        $skinawal->skin = $skin;
        $skinawal->save();
        return response()->json('min sukses');
    }

    public function plus(Request $request, $id_user)//ok
    {
        $skinawal = Skin::where('id_user', $id_user)
                    ->first();
        $totalawal = Skin::where('id_user', $id_user)
                    ->first();
        $plus = $request->input('plus');
        $skin = $skinawal->skin + $plus;
        $skinawal->skin = $skin;
        $skinawal->save();
        $total = $totalawal->total + $plus;
        $totalawal->total = $total;
        $totalawal->save();
        return response()->json('plus sukses');
    }
}
