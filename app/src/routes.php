<?php

use Slim\Http\Request;
use Slim\Http\Response;

// Routes
$app->get('/', function (Request $request, Response $response, array $args) {
    $GLOBALS["SETTINGS"]["state"]["stdout"] = "Connection establish - ";
    $GLOBALS["SETTINGS"]["state"]["camera"] = [1];
    $response->getBody()->write( Helper::getJSONState() );
    return $response;
});

$app->get('/start[/{id_camera}]', function (Request $request, Response $response, array $args) {
    $cameraId = $args['id_camera'];
    Helper::recordVideo();
    $GLOBALS["SETTINGS"]["state"]["stdout"] = "Stream is recording";
    $response->getBody()->write( Helper::getJSONState() );
    return $response;
  });
  
$app->get('/picture[/{id_camera}]', function (Request $request, Response $response, array $args) {
    $cameraId = $args['id_camera']; 
    Helper::takePicture();
    $response->getBody()->write( Helper::getJSONState() );
    //Remove the base64 encode of the image before saving the state
    $GLOBALS["SETTINGS"]["state"]["stdout"] = "";
    return $response;
});

$app->get('/stop[/{id_camera}]', function (Request $request, Response $response, array $args) { 
    $cameraId = $args['id_camera'];   
    Helper::stopVideo();
    $GLOBALS["SETTINGS"]["state"]["stdout"] = "Stream stopped";
    $response->getBody()->write( Helper::getJSONState() );
    return $response;
});

$app->map(['GET', 'POST', 'PUT', 'DELETE', 'PATCH'], '/{routes:.+}', function($req, $res) {
  $handler = $this->notFoundHandler; // handle using the default Slim page not found handler
  return $handler($req, $res);
});


