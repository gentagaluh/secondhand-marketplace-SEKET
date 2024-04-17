<?php

namespace App\Http\Controllers;

use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\File;

class ApiProduct extends Controller
{
    public function getByIklan1()//ok
    {
        $product = DB::table('products')->join('user_partners', 'products.id_user', '=', 'user_partners.id')
                                        ->select('products.kategori', 'products.nama_produk', 'products.harga', 'products.foto_produk', 'products.sub_kategori', 'products.deskripsi',
                                                'user_partners.kota', 'user_partners.foto_profil', 'user_partners.nama', 'user_partners.nomor_hp', 'user_partners.id', 'products.id as id_produk')
                                        ->where('products.sold', 'no')
                                        ->where('iklan1', 'yes')
                                        ->get();
        return response()->json(['message'=>'iklan1', 'data'=>$product]);
    }

    public function add(Request $request)//ok
    {
        $input = $request->all();
        if($request->has('foto_produk')){
            $foto = $request->file('foto_produk');
            $nama_foto = 'PRODUCT_'.time().rand(0, 9).'.'.$foto->getClientOriginalExtension();
            $foto->move('image/product',$nama_foto);
            $input['foto_produk'] = $nama_foto;
        }
        Product::create($input);
        return response()->json('add produk sukses');

    }

    public function getByNotSoldId($id_user)//ok
    {
        $product = DB::table('products')->join('user_partners', 'products.id_user', '=', 'user_partners.id')
                                        ->select('products.kategori', 'products.nama_produk', 'products.harga', 'products.foto_produk', 'products.sub_kategori', 'products.deskripsi',
                                                'user_partners.kota', 'user_partners.foto_profil', 'user_partners.nama', 'user_partners.nomor_hp', 'user_partners.id', 'products.id as id_produk')
                                        ->where('products.sold', 'no')
                                        ->where('id_user', $id_user)
                                        ->orderBy('products.id', 'DESC')
                                        ->get();
        return response()->json(['message'=>'notsoldid', 'data'=>$product]);
    }

    public function getBySoldId($id_user)//ok
    {
        $product = DB::table('products')->join('user_partners', 'products.id_user', '=', 'user_partners.id')
                                        ->select('products.nama_produk', 'products.harga', 'products.foto_produk', 'products.id as id_produk',
                                        'user_partners.foto_profil','user_partners.kota','user_partners.nama', 'user_partners.id')
                                        ->where('products.sold', 'yes')
                                        ->where('id_user', $id_user)
                                        ->orderBy('products.id', 'DESC')
                                        ->get();
        return response()->json(['message'=>'soldid', 'data'=>$product]);
    }

    public function getByIklan2()//ok
    {
        $product = DB::table('products')->join('user_partners', 'products.id_user', '=', 'user_partners.id')
                                        ->select('products.kategori', 'products.nama_produk', 'products.harga', 'products.foto_produk', 'products.sub_kategori', 'products.deskripsi',
                                                'user_partners.kota', 'user_partners.foto_profil', 'user_partners.nama', 'user_partners.nomor_hp', 'user_partners.id', 'products.id as id_produk')
                                        ->where('products.sold', 'no')
                                        ->where('iklan2', 'yes')
                                        ->orderBy('products.id', 'DESC')
                                        ->get();
        return response()->json(['message'=>'iklan2', 'data'=>$product]);
    }

    public function getByNotSold()//ok
    {
        $product = DB::table('products')->join('user_partners', 'products.id_user', '=', 'user_partners.id')
                                        ->select('products.kategori', 'products.nama_produk', 'products.harga', 'products.foto_produk', 'products.sub_kategori', 'products.deskripsi',
                                                'user_partners.kota', 'user_partners.foto_profil', 'user_partners.nama', 'user_partners.nomor_hp', 'user_partners.id', 'products.id as id_produk')
                                        ->where('products.sold', 'no')
                                        ->where('products.iklan2', 'no')
                                        ->orderBy('products.id', 'DESC')
                                        ->get();
        return response()->json(['message'=>'notsold', 'data'=>$product]);
    }

    public function getBySold()//ok
    {
        $product = DB::table('products')->join('user_partners', 'products.id_user', '=', 'user_partners.id')
                                        ->select('products.nama_produk', 'products.harga', 'products.foto_produk', 'products.id as id_produk',
                                        'user_partners.foto_profil','user_partners.kota', 'user_partners.nama', 'user_partners.id')
                                        ->where('products.sold', 'yes')
                                        ->orderBy('products.id', 'DESC')
                                        ->get();
        return response()->json(['message'=>'sold', 'data'=>$product]);
    }

    public function getFavoritId($id_buyer)//ok
    {
        $product = DB::table('products')->join('favs', 'favs.id_produk', '=', 'products.id')
                                        ->join('user_partners', 'products.id_user', '=', 'user_partners.id')
                                        ->select('products.kategori', 'products.nama_produk', 'products.harga', 'products.foto_produk', 'products.sub_kategori', 'products.deskripsi',
                                                'user_partners.kota', 'user_partners.foto_profil', 'user_partners.nama', 'user_partners.nomor_hp', 'user_partners.id', 'products.id as id_produk')
                                        ->where('products.sold', 'no')
                                        ->where('favs.id_buyer', $id_buyer)
                                        ->orderBy('favs.id', 'DESC')
                                        ->get();
        return response()->json(['message'=>'favorit', 'data'=>$product]);
    }

    public function SearchFav(Request $request)//ok
    {
        $nama = $request->input('search');
        $id_buyer = $request->input('id_buyer');
        $product = DB::table('products')->join('favs', 'favs.id_produk', '=', 'products.id')
                                        ->join('user_partners', 'products.id_user', '=', 'user_partners.id')
                                        ->select('products.kategori', 'products.nama_produk', 'products.harga', 'products.foto_produk', 'products.sub_kategori', 'products.deskripsi',
                                                'user_partners.kota', 'user_partners.foto_profil', 'user_partners.nama', 'user_partners.nomor_hp', 'user_partners.id', 'products.id as id_produk')
                                        ->where('products.sold', 'no')
                                        ->where('products.nama_produk', 'like', '%'.$nama.'%')
                                        ->where('favs.id_buyer', $id_buyer)
                                        ->orderBy('favs.id', 'DESC')
                                        ->get();
        $count = $product->count();
        if($count > 0){
            return response()->json(['message'=>'favorit', 'data'=>$product]);
        }else{
            return response()->json(['message'=>'tidak ada']);
        }
    }

    public function getKategori($kategori)//ok
    {
        $product = DB::table('products')->join('user_partners', 'products.id_user', '=', 'user_partners.id')
                                        ->select('products.kategori', 'products.nama_produk', 'products.harga', 'products.foto_produk', 'products.sub_kategori', 'products.deskripsi',
                                                'user_partners.kota', 'user_partners.foto_profil', 'user_partners.nama', 'user_partners.nomor_hp', 'user_partners.id', 'products.id as id_produk')
                                        ->where('products.sold', 'no')
                                        ->where('kategori', $kategori)
                                        ->orderBy('products.id', 'DESC')
                                        ->get();
        return response()->json(['message'=>'produk kategori', 'data'=>$product]);
    }

    public function getSubKategori($subkategori)//ok
    {
        $product = DB::table('products')->join('user_partners', 'products.id_user', '=', 'user_partners.id')
                                        ->select('products.kategori', 'products.nama_produk', 'products.harga', 'products.foto_produk', 'products.sub_kategori', 'products.deskripsi',
                                                'user_partners.kota', 'user_partners.foto_profil', 'user_partners.nama', 'user_partners.nomor_hp', 'user_partners.id', 'products.id as id_produk')
                                        ->where('products.sold', 'no')
                                        ->where('sub_kategori', $subkategori)
                                        ->orderBy('products.id', 'DESC')
                                        ->get();
        return response()->json(['message'=>'produk subkategori', 'data'=>$product]);
    }

    public function delete($id)//ok
    {
        $product = Product::find($id);
        $nama_foto = $product->foto_produk;
        $path = public_path();
        $path_foto = $path.'/image/product/'.$nama_foto;
        if(File::exists($path_foto)){
            File::delete($path_foto);
        }
        $product->delete();
        return response()->json(['delete product sukses']);
    }

    public function edit(Request $request, $id)//ok
    {
        $product = Product::find($id);
        $product->update($request->all());
        return response()->json('edit product sukses');
    }

    public function addFoto(Request $request,$id)//ok
    {
        $product = Product::find($id);
        $foto = $request->file('foto_produk');
        $nama_foto = $product->foto_produk;
        $foto->move('image/product',$nama_foto);
        return response()->json('add foto success');
    }

    public function getByRated($id){//ok
        $product = DB::table('products')->join('user_partners', 'products.id_user', '=', 'user_partners.id')
                                        ->join('rates', 'rates.id_produk', '=', 'products.id')
                                        ->select('products.foto_produk', 'products.nama_produk', 'products.harga',
                                                'user_partners.kota', 'rates.total_rating')
                                        ->where('products.sold', 'rated')
                                        ->where('products.id_user', $id)
                                        ->orderBy('products.id', 'DESC')
                                        ->get();
        return response()->json(['message'=>'rated', 'data'=>$product]);

    }

    public function search(Request $request){//ok
        $nama = $request->input('search');
        $product = DB::table('products')->join('user_partners', 'products.id_user', '=', 'user_partners.id')
                                        ->select('products.kategori', 'products.nama_produk', 'products.harga', 'products.foto_produk', 'products.sub_kategori', 'products.deskripsi',
                                                'user_partners.kota', 'user_partners.foto_profil', 'user_partners.nama', 'user_partners.nomor_hp', 'user_partners.id', 'products.id as id_produk')
                                        ->where('products.sold', 'no')
                                        ->where('products.nama_produk', 'like', '%'.$nama.'%')
                                        ->orderBy('products.id', 'DESC')
                                        ->get();
        $count = $product->count();
        if($count > 0){
            return response()->json(['message'=>'search', 'data'=>$product]);
        }else{
            return response()->json(['message'=>'tidak ada']);
        }
    }
}
