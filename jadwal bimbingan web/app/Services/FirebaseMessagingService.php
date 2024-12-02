<?php

namespace App\Services;

use Kreait\Firebase\Messaging\Notification;
use Kreait\Firebase\Messaging\CloudMessage;
use Kreait\Laravel\Firebase\Facades\Firebase;

class FirebaseMessagingService
{
    public function sendNotificationToToken($title, $body, $token)
    {
        $notification = Notification::create($title, $body);
        $message = CloudMessage::new()
            ->withTarget('token', $token)
            ->withNotification($notification)
            ->withData([]);

        $messaging = Firebase::messaging();
        $messaging->send($message);
    }
}