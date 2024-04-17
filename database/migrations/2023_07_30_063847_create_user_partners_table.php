<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUserPartnersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('user_partners', function (Blueprint $table) {
            $table->id();
            $table->string('foto_profil');
            $table->string('nama');
            $table->string('kota');
            $table->integer('tahun_kelahiran');
            $table->string('nomor_hp');
            $table->string('password');
            $table->string('partner')->default('no');
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
        Schema::dropIfExists('user_partners');
    }
}
