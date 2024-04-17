<?php

use App\Http\Controllers\AdminController;
use App\Http\Controllers\ApiFav;
use App\Http\Controllers\ApiKategori;
use App\Http\Controllers\ApiNotif;
use App\Http\Controllers\ApiProduct;
use App\Http\Controllers\ApiRate;
use App\Http\Controllers\ApiSaran;
use App\Http\Controllers\ApiSkin;
use App\Http\Controllers\ApiSubKategori;
use App\Http\Controllers\ApiUserPartner;
use Facade\FlareClient\Api;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

//userPartner
Route::post('/user/register', [ApiUserPartner::class, 'register']);
Route::post('/user/login', [ApiUserPartner::class, 'login']);
Route::post('/user/addfoto/{id}', [ApiUserPartner::class, 'addFoto']);
Route::get('/user/pic/id/{id_user}', [ApiUserPartner::class, 'getPicById']);
Route::get('/user/info/id/{id}', [ApiUserPartner::class, 'getInfo']);
Route::put('/user/edit/{id}', [ApiUserPartner::class, 'edit']);

//produk
Route::post('/product/add', [ApiProduct::class, 'add']);
Route::post('/product/addfoto/{id}', [ApiProduct::class, 'addFoto']);
Route::post('/product/search', [ApiProduct::class, 'search']);
Route::post('/product/searchfav', [ApiProduct::class, 'SearchFav']);
Route::get('/product/iklan1', [ApiProduct::class, 'getByIklan1']);
Route::get('/product/iklan2', [ApiProduct::class, 'getByIklan2']);
Route::get('/product/notsold/id/{id_user}', [ApiProduct::class, 'getByNotSoldId']);
Route::get('/product/sold/id/{id_user}', [ApiProduct::class, 'getBySoldId']);
Route::get('/product/notsold', [ApiProduct::class, 'getByNotSold']);
Route::get('/product/sold', [ApiProduct::class, 'getBySold']);
Route::get('/product/favorit/{id_buyer}', [ApiProduct::class, 'getFavoritId']);
Route::get('/product/kategori/{kategori}', [ApiProduct::class, 'getKategori']);
Route::get('/product/subkategori/{subkategori}', [ApiProduct::class, 'getSubKategori']);
Route::get('/product/rated/{id}', [ApiProduct::class, 'getByRated']);
Route::delete('/product/delete/{id}', [ApiProduct::class, 'delete']);
Route::put('/product/edit/{id}', [ApiProduct::class, 'edit']);

//skin
Route::post('/skin/add', [ApiSkin::class, 'add']);
Route::get('/skin/id/{id_user}', [ApiSkin::class, 'getSkinById']);
Route::put('/skin/min/{id_user}', [ApiSkin::class, 'min']);
Route::put('/skin/plus/{id_user}', [ApiSkin::class, 'plus']);

//kategori
Route::get('/kategori/all', [ApiKategori::class, 'getKategori']);

//rate
Route::get('/rate/avg/id/{id_user}', [ApiRate::class, 'getRateByAvgId']);
Route::post('/rate/add', [ApiRate::class, 'add']);

//favorit
Route::post('/favorit/add', [ApiFav::class, 'add']);
Route::delete('/favorit/delete/{id_buyer}/{id_produk}', [ApiFav::class, 'delete']);

//notif
Route::post('/notif/add', [ApiNotif::class, 'add']);
Route::get('/notif/id/{id_user}', [ApiNotif::class, 'getById']);
Route::delete('/notif/delete/{id}', [ApiNotif::class, 'delete']);

//subkategori
Route::get('/subkategori/kategori/{kategori}', [ApiSubKategori::class, 'getByKategori']);

//saran
Route::post('/saran/add', [ApiSaran::class, 'add']);