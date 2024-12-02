<?php
$url = "https://apbs.pinday.top/cron-metode-genetic";

$ch = curl_init();

curl_setopt($ch, CURLOPT_URL, $url);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($ch, CURLOPT_HTTPHEADER, [
    'Content-Type: application/json'
]);

$response = curl_exec($ch);

if (curl_errno($ch)) {
    error_log('Error:' . curl_error($ch));
} else {
    echo $response;
}

curl_close($ch);
?>