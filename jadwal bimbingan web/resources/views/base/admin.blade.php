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
    <link href="https://fonts.googleapis.com/css2?family=Overpass:ital,wght@0,100;0,200;0,300;0,400;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
    <!-- Icons CSS -->
    <link rel="stylesheet" href="/dashboard/css/feather.css">
    <link rel="stylesheet" href="/dashboard/css/dataTables.bootstrap4.css">
    <!-- Date Range Picker CSS -->
    <link rel="stylesheet" href="/dashboard/css/daterangepicker.css">
    <!-- App CSS -->
    <link rel="stylesheet" href="/dashboard/css/app-light.css" id="lightTheme" disabled>
    <link rel="stylesheet" href="/dashboard/css/app-dark.css" id="darkTheme">

    @yield('css')
  </head>
  <body class="vertical  dark  ">
    <div class="wrapper">
      <nav class="topnav navbar navbar-light">
        <button type="button" class="navbar-toggler text-muted mt-2 p-0 mr-3 collapseSidebar">
          <i class="fe fe-menu navbar-toggler-icon"></i>
        </button>
        <ul class="nav">
          <li class="nav-item">
            <a class="nav-link text-muted my-2" href="#" id="modeSwitcher" data-mode="dark">
              <i class="fe fe-sun fe-16"></i>
            </a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle text-muted pr-0" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              <span class="avatar avatar-sm mt-2">
                <img src="/dashboard/assets/avatars/face-1.jpg" alt="..." class="avatar-img rounded-circle">
              </span>
            </a>
            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdownMenuLink">
              <a class="dropdown-item" href="/logout">Keluar</a>
            </div>
          </li>
        </ul>
      </nav>
      <aside class="sidebar-left border-right bg-white shadow" id="leftSidebar" data-simplebar>
        <a href="#" class="btn collapseSidebar toggle-btn d-lg-none text-muted ml-2 mt-3" data-toggle="toggle">
          <i class="fe fe-x"><span class="sr-only"></span></i>
        </a>
        <nav class="vertnav navbar navbar-light">
          <!-- nav bar -->
          <div class="w-100 mb-4 d-flex">
            <a class="navbar-brand mx-auto mt-2 flex-fill text-center" href="/">
              <img src="/logo_iti.png" class="img-fluid" width="150" alt="">
            </a>
          </div>
          <ul class="navbar-nav flex-fill w-100 mb-2">
            <p class="text-muted nav-heading mt-4 mb-1">
              <span>Menu</span>
            </p>
            <ul class="navbar-nav flex-fill w-100 mb-2">
              <li class="nav-item w-100">
                <a class="nav-link" href="/pengguna">
                  <i class="fe fe-users fe-16"></i>
                  <span class="ml-3 item-text">Akun</span>
                </a>
              </li>
            </ul>
            <ul class="navbar-nav flex-fill w-100 mb-2">
              <li class="nav-item w-100">
                <a class="nav-link" href="/dosen">
                  <i class="fe fe-briefcase fe-16"></i>
                  <span class="ml-3 item-text">Dosen</span>
                </a>
              </li>
            </ul>
            <ul class="navbar-nav flex-fill w-100 mb-2">
              <li class="nav-item w-100">
                <a class="nav-link" href="/mahasiswa">
                  <i class="fe fe-user fe-16"></i>
                  <span class="ml-3 item-text">Mahasiswa</span>
                </a>
              </li>
            </ul>
            <ul class="navbar-nav flex-fill w-100 mb-2">
              <li class="nav-item w-100">
                <a class="nav-link" href="/bimbingan">
                  <i class="fe fe-calendar fe-16"></i>
                  <span class="ml-3 item-text">Bimbingan</span>
                </a>
              </li>
            </ul>
          </ul>
        </nav>
      </aside>

      @yield('content')

    </div> <!-- .wrapper -->
    <script src="/dashboard/js/jquery.min.js"></script>
    <script src="/dashboard/js/popper.min.js"></script>
    <script src="/dashboard/js/moment.min.js"></script>
    <script src="/dashboard/js/bootstrap.min.js"></script>
    <script src="/dashboard/js/simplebar.min.js"></script>
    <script src='/dashboard/js/daterangepicker.js'></script>
    <script src='/dashboard/js/jquery.stickOnScroll.js'></script>
    <script src="/dashboard/js/tinycolor-min.js"></script>
    <script src="/dashboard/js/config.js"></script>
    <script src='/dashboard/js/jquery.dataTables.min.js'></script>
    <script src='/dashboard/js/dataTables.bootstrap4.min.js'></script>
    <script>
      $('#dataTable-1').DataTable(
      {
        autoWidth: true,
        "lengthMenu": [
          [16, 32, 64, -1],
          [16, 32, 64, "All"]
        ]
      });
    </script>
    <script src="/dashboard/js/apps.js"></script>
    <!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-56159088-1"></script>
    <script>
      window.dataLayer = window.dataLayer || [];

      function gtag()
      {
        dataLayer.push(arguments);
      }
      gtag('js', new Date());
      gtag('config', 'UA-56159088-1');
    </script>

    @yield('js')
  </body>
</html>