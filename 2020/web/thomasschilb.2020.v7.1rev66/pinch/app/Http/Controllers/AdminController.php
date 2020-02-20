<?php
namespace App\Http\Controllers;

use App\Dropbox;
use Illuminate\Http\Request;

class AdminController extends Controller
{
    private $api_client;
    private $content_client;
    private $access_token;

	public function __construct(Dropbox $dropbox)
    {
		$this->api_client = $dropbox->api();
		$this->content_client = $dropbox->content();
		$this->access_token = session('access_token');
	}


    public function dashboard()
    {
    	return view('admin.dashboard');
    }


    public function user()
    {
		$response = $this->api_client->request('POST', '/2/users/get_current_account', [
		    'headers' => [
		        'Authorization' => 'Bearer ' . $this->access_token
		    ]
		]);

		$user = json_decode($response->getBody(), true);

    	$page_data = [
    		'user' => $user
    	];

    	return view('admin.user', $page_data);
    }


    public function search(Request $request)
    {
    	$page_data = [
    		'path' => '',
    		'query' => '',
    		'matches' => []
    	];

    	if ($request->has('path') && $request->has('query')) {
			$path = $request->input('path');
    		$query = $request->input('query');

			$data = json_encode(
				[
					'path' => $path,
					'mode' => 'filename',
					'query' => $query
				]
			);

			$response = $this->api_client->request(
				'POST', '/2/files/search',
				[
				    'headers' => [
				        'Authorization' => 'Bearer ' . $this->access_token,
				        'Content-Type' => 'application/json'
				    ],
				    'body' => $data
			]);

			$search_results = json_decode($response->getBody(), true);
			$matches = $search_results['matches'];

    		$page_data = [
    			'path' => $path,
    			'query' => $query,
    			'matches' => $matches
    		];
    	}

    	return view('admin.search', $page_data);
    }


    public function revisions(Request $request)
    {
    	if ($request->has('path')) {
    		$path = $request->input('path');
			$data = json_encode([
				'path' => $path
			]);

			$response = $this->api_client->request(
				'POST', '/2/files/list_revisions',
				[
			   		'headers' => [
				        'Authorization' => 'Bearer ' . $this->access_token,
				        'Content-Type' => 'application/json'
			    	],
			    'body' => $data
			]);

			$revisions = json_decode($response->getBody(), true);

	    	$page_data = [
	    		'revisions' => $revisions['entries'],
	    		'path' => $path
	    	];

	    	return view('admin.revisions', $page_data);

    	} else {
    		return redirect('search');
    	}
    }


    public function restoreRevision(Request $request)
    {
    	if ($request->has('path') && $request->has('rev')) {

    		$path = $request->input('path');
    		$rev = $request->input('rev');

			$data = json_encode([
				'path' => $path,
				'rev' => $rev
			]);

			$response = $this->api_client->request(
				'POST', '/2/files/restore',
				[
				    'headers' => [
				        'Authorization' => 'Bearer ' . $this->access_token,
				        'Content-Type' => 'application/json'
				    ],
			    	'body' => $data
			]);

			$response_data = json_decode($response->getBody(), true);

			if (!empty($response_data)) {
				return redirect("revisions?path={$path}")
					->with('message', [
						'type' => 'success',
						'text' => "File has been restored to the following revision: {$response_data['rev']}"
					]);
			} else {
				return redirect("revisions?path={$path}")
					->with('message', [
						'type' => 'danger',
						'text' => 'The revision request failed. Please try again'
					]);
			}

    	} else {
    		return redirect('search');
    	}
    }


    public function download(Request $request)
    {
    	if ($request->has('path')) {
    		$path = $request->input('path');
			$data = json_encode([
				'path' => $path
			]);

			$response = $this->content_client->request(
				'POST',
				'/2/files/download',
				[
					'headers' => [
						'Authorization' => 'Bearer ' . $this->access_token,
						'Dropbox-API-Arg' => $data
					]
			]);

			$result = $response->getHeader('dropbox-api-result');
			$file_info = json_decode($result[0], true);

			$content = $response->getBody();

			$filename = $file_info['name'];
			$file_extension = substr($filename, strrpos($filename, '.'));
			$file = uniqid() . $file_extension;

			$file_size = $file_info['size'];

			return response($content)
				->header('Content-Description', 'File Transfer')
				->header('Content-Disposition', "attachment; filename={$file}")
				->header('Content-Transfer-Encoding', 'binary')
				->header('Connection', 'Keep-Alive')
				->header('Content-Length', $file_size);
    	} else {
    		return redirect('search');
    	}


    }


    public function upload()
    {
    	return view('admin.upload');
    }


    public function doUpload(Request $request)
    {
		if ($request->hasFile('file') && $request->has('path')) {

	    	$valid_mimetypes = [
	    		'image/png', 'image/jpeg', 'image/jpg', 'image/gif', 'image/bmp'
	    	];

	    	$valid_size = 5000000; //5Mb

	    	$mime_type = $request->file('file')->getMimeType();
			$size = $request->file('file')->getSize();
	    	$filename = $request->file('file')->getClientOriginalName();
	    	$path = $request->input('path') . '/' . $filename;

	    	if (in_array($mime_type, $valid_mimetypes) && $size <= $valid_size) {

				$data = json_encode([
					'path' => $path,
					'mode' => 'add',
					'autorename' => true,
					'mute' => false
				]);

				$response = $this->content_client->request(
					'POST', '/2/files/upload',
					[
						'headers' => [
							'Authorization' => 'Bearer ' . $this->access_token,
							'Content-Type' => 'application/octet-stream',
							'Dropbox-API-Arg' => $data
						],
						'body' => fopen($request->file('file'), 'r')
				]);

				$response_data = json_decode($response->getBody(), true);

				if (!empty($response_data['name'])) {

					$name = $response_data['name'];
		    		return redirect('upload')
		    			->with('message', [
		    				'type' => 'success',
		    				'text' => "File with the name {$name} was uploaded!"
		    			]);
				}

	    	}

		}

		return redirect('upload')
	    			->with('message', [
	    				'type' => 'danger',
	    				'text' => 'There was a problem uploading the file'
	    			]);
    }
}
