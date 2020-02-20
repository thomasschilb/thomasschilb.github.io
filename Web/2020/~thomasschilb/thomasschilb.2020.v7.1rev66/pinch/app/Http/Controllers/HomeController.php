<?php
namespace App\Http\Controllers;

use Purl\Url;
use App\Dropbox;
use Illuminate\Http\Request;

class HomeController extends Controller
{
    private $api_client;

	public function __construct(Dropbox $dropbox)
    {
		$this->api_client = $dropbox->api();
	}


    public function index()
    {
    	return view('index');
    }


    public function postIndex()
    {
		$url = new Url('https://www.dropbox.com/1/oauth2/authorize');

		$url->query->setData([
			'response_type' => 'code',
			'client_id' => env('DROPBOX_APP_KEY'),
			'redirect_uri' => env('DROPBOX_REDIRECT_URI')
		]);

		return redirect($url->getUrl());
    }

    public function login(Request $request)
    {
    	if ($request->has('code')) {

			$data = [
				'code' => $request->input('code'),
				'grant_type' => 'authorization_code',
				'client_id' => env('DROPBOX_APP_KEY'),
				'client_secret' => env('DROPBOX_APP_SECRET'),
				'redirect_uri' => env('DROPBOX_REDIRECT_URI')
			];

			$response = $this->api_client->request(
				'POST',
				'/1/oauth2/token',
				['form_params' => $data]
			);

			$response_body = json_decode($response->getBody(), true);
			$access_token = $response_body['access_token'];

			session(['access_token' => $access_token]);

			return redirect('dashboard');
    	}

    	return redirect('/');
    }
}
