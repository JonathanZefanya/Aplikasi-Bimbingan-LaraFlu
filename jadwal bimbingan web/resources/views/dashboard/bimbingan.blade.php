@extends('base.admin')

@section('css')
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/css/bootstrap-select.min.css">
@endsection

@section('js')
    <script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/js/bootstrap-select.min.js"></script>

    <script>
        $(function() {
            $('.selectpicker').selectpicker();
        });
    </script>
@endsection

@section('content')
    <main role="main" class="main-content">
        <div class="container-fluid">
            <div class="row justify-content-center">
                <div class="col-12">
                    <div class="row">
                        <!-- Small table -->
                        <div class="col-md-12 my-4">
                            <div class="row">
                                <div class="col">
                                    <h2 class="h4 mb-1">Manajemen Bimbingan</h2>
                                </div>
                                <div class="col">
                                    <button class="btn btn-primary float-right" data-toggle="modal"
                                        data-target="#addModal">Tambah Data</button>
                                </div>
                            </div>
                            <p class="mb-3">Kelola Data Bimbingan bimbingan dan Mahasiswa.</p>
                            <div class="card shadow">
                                <div class="card-body">


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

                                    <!-- table -->
                                    <div id="dataTable-1_wrapper" class="dataTables_wrapper dt-bootstrap4 no-footer">
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <table class="table datatables dataTable no-footer" id="dataTable-1"
                                                    role="grid" aria-describedby="dataTable-1_info">
                                                    <thead>
                                                        <tr role="row">
                                                            <th class="sorting" tabindex="0" aria-controls="dataTable-1"
                                                                rowspan="1" colspan="1" aria-label=""
                                                                style="width: 86.7063px;">Dosen</th>
                                                            <th class="sorting" tabindex="0" aria-controls="dataTable-1"
                                                                rowspan="1" colspan="1" aria-label=""
                                                                style="width: 60.4062px;">Mahasiswa</th>
                                                            <th class="sorting" tabindex="0" aria-controls="dataTable-1"
                                                                rowspan="1" colspan="1" aria-label=""
                                                                style="width: 60.4062px;">Aksi</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        @foreach ($bimbingans as $bimbingan)
                                                            <tr role="row" class="odd">
                                                                <td>{{ $bimbingan->dosen->dosen_nama }}</td>
                                                                <td>{{ $bimbingan->mahasiswa->mahasiswa_nama }}</td>
                                                                <td><button
                                                                        class="btn btn-sm dropdown-toggle more-horizontal"
                                                                        type="button" data-toggle="dropdown"
                                                                        aria-haspopup="true" aria-expanded="false">
                                                                        <span class="text-muted sr-only">Aksi</span>
                                                                    </button>
                                                                    <div class="dropdown-menu dropdown-menu-right">
                                                                        <a class="dropdown-item" href="#"
                                                                            data-toggle="modal"
                                                                            data-target="#editModal{{ $bimbingan->bimbingan_id }}">Ubah</a>
                                                                        <a class="dropdown-item" href="#"
                                                                            data-toggle="modal"
                                                                            data-target="#deleteModal{{ $bimbingan->bimbingan_id }}">Hapus</a>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        @endforeach
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div> <!-- customized table -->
                    </div> <!-- end section -->
                </div> <!-- .col-12 -->
            </div> <!-- .row -->
        </div> <!-- .container-fluid -->

        <div class="modal fade" id="addModal" data-backdrop="static" data-keyboard="false" tabindex="-1"
            aria-labelledby="addModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addModalLabel">Tambah Data</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form action="/tambah-bimbingan" method="POST">
                        @csrf
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Dosen</label>
                                <select name="dosen_id" id=""
                                    class="form-control selectpicker" data-live-search="true" required>
                                    <option value="">--- Pilih Dosen ---</option>
                                    @foreach ($dosens as $dosen)
                                        <option value="{{ $dosen->dosen_id }}">{{ $dosen->dosen_nama }}</option>
                                    @endforeach
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Mahasiswa</label>
                                <select name="mahasiswa_id" id=""
                                    class="form-control selectpicker" data-live-search="true" required>
                                    <option value="">--- Pilih Mahasiswa ---</option>
                                    @foreach ($mahasiswas as $mahasiswa)
                                        <option value="{{ $mahasiswa->mahasiswa_id }}">{{ $mahasiswa->mahasiswa_nama }}
                                        </option>
                                    @endforeach
                                </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                            <button type="submit" class="btn btn-primary">Tambah</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        @foreach ($bimbingans as $bimbingan)
            <div class="modal fade" id="editModal{{ $bimbingan->bimbingan_id }}" data-backdrop="static"
                data-keyboard="false" tabindex="-1" aria-labelledby="editModal{{ $bimbingan->bimbingan_id }}Label"
                aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="editModal{{ $bimbingan->bimbingan_id }}Label">Ubah Data</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <form action="/ubah-bimbingan" method="POST">
                            @csrf
                            <input type="hidden" name="id" value="{{ $bimbingan->bimbingan_id }}">
                            <div class="modal-body">
                                <div class="form-group">
                                    <label>Dosen</label>
                                    <select name="dosen_id" id=""
                                        class="form-control selectpicker" data-live-search="true" required>
                                        @foreach ($dosens as $dosen)
                                            <option value="{{ $dosen->dosen_id }}" @if($bimbingan->dosen_id == $dosen->dosen_id) selected @endif>{{ $dosen->dosen_nama }}</option>
                                        @endforeach
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Mahasiswa</label>
                                    <select name="mahasiswa_id" id=""
                                        class="form-control selectpicker" data-live-search="true" required>
                                        @foreach ($mahasiswas as $mahasiswa)
                                            <option value="{{ $mahasiswa->mahasiswa_id }}" @if($bimbingan->mahasiswa_id == $mahasiswa->mahasiswa_id) selected @endif>{{ $mahasiswa->mahasiswa_nama }}
                                            </option>
                                        @endforeach
                                    </select>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                                <button type="submit" class="btn btn-warning">Ubah</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="deleteModal{{ $bimbingan->bimbingan_id }}" data-backdrop="static"
                data-keyboard="false" tabindex="-1" aria-labelledby="deleteModal{{ $bimbingan->bimbingan_id }}Label"
                aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="deleteModal{{ $bimbingan->bimbingan_id }}Label">Hapus Data</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            Anda yakin ingin menghapus data ini?
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                            <a href="/hapus-bimbingan/{{ $bimbingan->bimbingan_id }}" class="btn btn-danger">Hapus</a>
                        </div>
                    </div>
                </div>
            </div>
        @endforeach
    </main> <!-- main -->
@endsection
