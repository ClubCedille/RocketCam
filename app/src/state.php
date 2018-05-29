<?php
/**
 * 
 * This file will load the session from a json file.
 * The Json file will be on the root directory of this app and will be created by
 * The first api call.
 * This is handled this way in order to have a global state between the app and that state must be 
 * The same for any clients (can't relly on phpsesid since it need to be shared)
 * 
 **/

$file = @file_get_contents(__DIR__ . "/../session.json");
$GLOBALS["SETTINGS"] = $file ? json_decode($file, true) : [];

if( !isset($GLOBALS["SETTINGS"]["state"]) ) {
  $GLOBALS["SETTINGS"]["state"] = [
                                    "running" => false,
                                    "connected" => true,
                                    "stdout" => ''
                                  ];
} else {
  $GLOBALS["SETTINGS"]["state"]["stdout"] = "";
}