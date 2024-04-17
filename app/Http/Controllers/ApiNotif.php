<?php

namespace App\Http\Controllers;

use App\Models\Notif;
use Illuminate\Http\Request;

class ApiNotif extends Controller
{
    public function add(Request $request)//ok
    {
        Notif::create($request->all());
        return response()->json('add notif sukses');
    }

    public function getById($id_user)//ok
    {
        $notif = Notif::where('id_user', $id_user)
                        ->select('foto', 'notif', 'id', 'created_at')
                        ->get();
        return response()->json(['message'=>'notif', 'data'=>$notif]);
    }

    public function delete($id)//ok
    {
        $notif = Notif::find($id);
        $notif->delete();
        return response()->json('delete sukses');
    }
}
