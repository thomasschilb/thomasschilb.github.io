<?php 
namespace App\Http\Middleware;

use Closure;

class AdminMiddleware {


    public function handle($request, Closure $next)
    {

        if($request->session()->has('access_token')){
            return $next($request);
        }

        return redirect('/')
            ->with('message', array('type' => 'danger', 'text' => 'You need to login'));

    }

}
