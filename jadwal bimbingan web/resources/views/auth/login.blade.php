<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="/logo_iti.png">
    <title>Aplikasi Penjadwalan Bimbingan</title>
    <!-- Simple bar CSS -->
    <link rel="stylesheet" href="/dashboard/css/simplebar.css">
    <!-- Fonts CSS -->
    <link
        href="https://fonts.googleapis.com/css2?family=Overpass:ital,wght@0,100;0,200;0,300;0,400;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,600;1,700;1,800;1,900&display=swap"
        rel="stylesheet">
    <!-- Icons CSS -->
    <link rel="stylesheet" href="/dashboard/css/feather.css">
    <!-- Date Range Picker CSS -->
    <link rel="stylesheet" href="/dashboard/css/daterangepicker.css">
    <!-- App CSS -->
    <link rel="stylesheet" href="/dashboard/css/app-light.css" id="lightTheme" disabled>
    <link rel="stylesheet" href="/dashboard/css/app-dark.css" id="darkTheme">
</head>

<body class="dark ">
    <div class="wrapper vh-100">
        <div class="row align-items-center h-100">
            <form class="col-lg-3 col-md-4 col-10 mx-auto text-center" action="/" method="POST">
              <h1 class="h6 mb-3">Aplikasi Penjadwalan Bimbingan Mahasiswa</h1>
              <br>
                @csrf

                @if (session('error'))
                    <div class="alert alert-danger fade show" role="alert">
                        {{ session('error') }}
                    </div>
                @endif
                @if (session('success'))
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        {{ session('success') }}
                    </div>
                @endif

                <div class="form-group">
                    <label for="" class="sr-only">Username</label>
                    <input type="text" name="username" class="form-control form-control-lg" placeholder="Username"
                        required="" autofocus="">
                </div>
                <div class="form-group">
                    <label for="inputPassword" class="sr-only">Password</label>
                    <input type="password" name="password" id="inputPassword" class="form-control form-control-lg"
                        placeholder="Password" required="">
                </div>
                <button class="btn btn-lg btn-primary btn-block" type="submit">Masuk</button>
            </form>
        </div>
    </div>
    <script src="/dashboard/js/jquery.min.js"></script>
    <script src="/dashboard/js/popper.min.js"></script>
    <script src="/dashboard/js/moment.min.js"></script>
    <script src="/dashboard/js/bootstrap.min.js"></script>
    <script src="/dashboard/js/simplebar.min.js"></script>
    <script src='/dashboard/js/daterangepicker.js'></script>
    <script src='/dashboard/js/jquery.stickOnScroll.js'></script>
    <script src="/dashboard/js/tinycolor-min.js"></script>
    <script src="/dashboard/js/config.js"></script>
    <script src="/dashboard/js/apps.js"></script>
    <!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-56159088-1"></script>
    <script>
        window.dataLayer = window.dataLayer || [];

        function gtag() {
            dataLayer.push(arguments);
        }
        gtag('js', new Date());
        gtag('config', 'UA-56159088-1');
    </script>
</body>

</html>
</body>

</html>
