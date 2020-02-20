<?php
namespace App;

use GuzzleHttp\Client;

class Dropbox {

	public function api()
    {
		$client = new Client([
		    'base_uri' => 'https://api.dropboxapi.com',
		]);
		return $client;
	}


	public function content(){
		$client = new Client([
		    'base_uri' => 'https://content.dropboxapi.com'
		]);

		return $client;
	}

}