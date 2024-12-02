<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Services\FirebaseMessagingService;
use Illuminate\Http\Request;
use Illuminate\Support\Env;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Redirect;
use Kreait\Laravel\Firebase\Facades\Firebase;
use Kreait\Firebase\Factory;
use Kreait\Firebase\ServiceAccount;

class AuthController extends Controller
{

    protected $firebaseMessagingService;

    public function __construct(FirebaseMessagingService $firebaseMessagingService)
    {
        $this->firebaseMessagingService = $firebaseMessagingService;
    }

    public function sendNotification()
    {
        return response()->json(['message' => 'Notifikasi berhasil dikirim']);
    }

    public function login(Request $request) {
        if($request->method() == 'GET') {
            // $this->sendNotification();
            return view('auth.login');
        } elseif($request->method() == 'POST') {
            $user = User::where('username', $request->username)->first();
            if(Auth::attempt(['username' => $request->username, 'password' => $request->password])) {
                if($user->level == 'admin') {
                    Auth::login($user);
                    return redirect('/pengguna');
                }else {
                    return back()->with('error', 'Anda tidak memiliki akses!');
                }
            } else {
                return back()->with('error', 'Username atau Password salah!');
            }
        } else {
            abort(505);
        }
    }

    public function logout() {
        Auth::logout();
        return redirect('/');
    }
}
