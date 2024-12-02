<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Genetic Algorithm Result</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .container {
            max-width: 600px;
            margin: auto;
            background: #f9f9f9;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
        }
        .result {
            margin-top: 20px;
        }
        ul {
            list-style-type: none;
            padding: 0;
        }
        li {
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Genetic Algorithm Result</h1>
        <h2>Dosen: {{ $dosen->dosen_nama }}</h2>
        <div class="result">
            <h3>5 Mahasiswa Terpilih:</h3>
            <ul>
                @foreach ($selectedStudents as $student)
                    <li>{{ $student->mahasiswa_nama }} - Jumlah bimbingan: {{ $student->mahasiswa_total_bimbingan }}</li>
                @endforeach
            </ul>
        </div>
    </div>
</body>
</html>