<!doctype html>
<html lang="en">
  <head>
    <style>
      .square-image{
        width: 100%;
  padding-top: 100%;
  background-size: cover;
      }
    </style>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.2.1/dist/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
    
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.6/dist/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.2.1/dist/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>
    <title>Home</title>
  </head>
  <body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
      <a class="navbar-brand"><img src="http://192.168.1.191:8000/image/kategori/{{$kategori[0]['nama_kategori']}}.png" height="50" alt="">

</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
      <ul class="navbar-nav">
        <li class="nav-item">
        <a href="/" class="nav-link">Home</a>
        </li>
      </ul>
      <ul class="navbar-nav ml-auto">
          <li class="nav-item">
            <a href="https://wa.me/+6282314355261?text=Halo min!" class="nav-link">Hubungi Kami</a>
          </li>
          <li class="nav-item">
            <a href="" class="nav-link">Dapatkan Aplikasi</a>
          </li>
        </ul>
      </div>
    </nav>


    <div class="container mb-3 mt-1">
    <h1>{{$kategori[0]['nama_kategori']}}</h1>
      <div class="dropdown">
        <a class="btn btn-secondary dropdown-toggle" href="" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Pilih Sub Kategori</a>
        <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
          @foreach($subkategori as $sbktgr)
            <a class="dropdown-item" href="{{$kategori[0]['nama_kategori']}}/{{$sbktgr->nama_subkategori}}">{{$sbktgr->nama_subkategori}}</a>
          @endforeach
        </div>
      </div>
    </div>
    <div class="container">
      <div class="row">
        @foreach($produk as $prdk)
        <div class="col-md-3 mb-3">
          <div class="card">
                    <div class="square-image" style="background-image: url('http://192.168.1.191:8000/image/product/{{$prdk->foto_produk}}')"></div>
                    <div class="card-body">
                      <h5 class="card-title">{{$prdk->nama_produk}}</h5>
                      <p class="card-text">Rp{{$prdk->harga}}</p>
                      <p class="card-text">{{$prdk->nama_produk}}</p>
                      <a href="https://wa.me/+62{{$prdk->nomor_hp}}?text=Permisi, saya melihat {{$prdk->nama_produk}} di website SeKet, apakah masih tersedia?" class="btn btn-success">Hubungi Penjual</a>
                    </div>
          </div>
        </div>
        @endforeach
      </div>
    </div>
  </body>
</html>