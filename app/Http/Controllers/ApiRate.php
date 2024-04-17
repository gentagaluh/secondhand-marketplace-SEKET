<?php

namespace App\Http\Controllers;

use App\Models\Rate;
use Illuminate\Http\Request;

class ApiRate extends Controller
{
    public function getRateByAvgId($id_user)//ok
    {
        $avgrate = Rate::where('id_user', $id_user)
                        ->avg('total_rating');
        $roundedavgrate = number_format($avgrate, 1);
        return response()->json(['message'=>'avg','data'=>$roundedavgrate]);
    }

    public function add(Request $request)//ok
    {
        $input = $request->all();
        if($request->has('bukti_pembelian')){
            $foto = $request->file('bukti_pembelian');
            $nama_foto = 'RATE_'.time().rand(0, 9).'.'.$foto->getClientOriginalExtension();
            $foto->move('image/rate',$nama_foto);
            $input['bukti_pembelian'] = $nama_foto;
        }
        Rate::create($input);
        return response()->json('add rate sukses');
    }
}
