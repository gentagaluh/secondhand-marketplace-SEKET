<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateProductsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('products', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('id_user');
            $table->string('kategori');
            $table->string('sub_kategori');
            $table->string('foto_produk');
            $table->string('foto_produk1')->default('no');
            $table->string('foto_produk2')->default('no');
            $table->string('foto_produk3')->default('no');
            $table->string('nama_produk');
            $table->text('deskripsi');
            $table->integer('harga');
            $table->string('iklan1')->default('no');
            $table->string('iklan2')->default('no');
            $table->string('sold')->default('no');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('products');
    }
}
