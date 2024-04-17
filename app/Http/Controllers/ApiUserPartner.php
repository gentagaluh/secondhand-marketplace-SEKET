<?php

namespace App\Http\Controllers;

use App\Models\Admin;
use App\Models\UserPartner;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class ApiUserPartner extends Controller
{
    public function register(Request $request)//ok
    {
        $input = $request->all();
        if($request->has('foto_profil')){
            $foto = $request->file('foto_profil');
            $nama_foto = 'USER_'.time().rand(0, 9).'.'.$foto->getClientOriginalExtension();
            $foto->move('image/userPartner',$nama_foto);
            $input['foto_profil'] = $nama_foto;
        }
        if($request->has('password')){
            $inputpw = $request->input('password');
            $input['password'] = Hash::make($inputpw);
        }
        $nmr = $request->input('nomor_hp');
        $ceknmr = UserPartner::where('nomor_hp', $nmr)
                            ->count();
        if($ceknmr > 0){
            return response()->json(['message'=>'sudah ada']);
        }else{
            $id = DB::table('user_partners')->insertGetId($input);
            return response()->json(['message'=>'id', 'data'=>$id]);
        }
    }

    public function addFoto(Request $request,$id)//ok
    {
        $user = UserPartner::find($id);
        $foto = $request->file('foto_profil');
        $nama_foto = $user->foto_profil;
        $foto->move('image/userPartner',$nama_foto);
        return response()->json('add foto success');
    }

    public function getPicById($id_user)//ok
    {
        $userPartner = UserPartner::select('foto_profil')
                                    ->where('id', $id_user)
                                    ->get();
        return response()->json(['message'=>'foto_profil', 'data' => $userPartner]);
    }

    public function getInfo($id)//ok
    {
        $userPartner = UserPartner::where('id', $id)
                                    ->select('nama', 'kota', 'foto_profil')
                                    ->get();
        return response()->json(['message'=>'info', 'data'=>$userPartner]);
    }

    public function edit(Request $request, $id)//ok
    {
        $userPartner = UserPartner::where('id', $id)
                                    ->select('nama', 'kota');
        $userPartner->update($request->only(['nama', 'kota']));
        return response()->json('update user sukses');
    }

    public function login(Request $request)//ok
    {
        $nomor = UserPartner::where('nomor_hp', $request->input('nomor_hp'))
                            ->first();
        if($nomor && Hash::check($request->input('password'), $nomor->password)){
            return response()->json(['message'=>'sukses', 'data'=>$nomor->id]);
        }else{
            return response()->json(['message'=>'gagal']);
        }
    }
}
