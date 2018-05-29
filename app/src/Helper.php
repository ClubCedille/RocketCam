<?php

class Helper {
 
  public static function is_process_running($PID) {
    return file_exists( "/proc/$PID" );
  }
  public static function getPID(){
    $pid = shell_exec("pidof raspivid");
    return intval($pid);
  }
  public static function setIsRunning(){
    $GLOBALS["SETTINGS"]["state"]["running"] = Helper::is_process_running($GLOBALS["SETTINGS"]["pid"]);
  }
  public static function getJSONState(){
    return json_encode($GLOBALS["SETTINGS"]["state"]);
  }
  public static function takePicture(){
    $timestamp = time();
    $out = shell_exec("/opt/vc/bin/raspistill -q 30 -w 480 -h 320 -o /var/www/html/picture/picture-$timestamp.jpg");
    $GLOBALS["SETTINGS"]["state"]["stdout"] = base64_encode(file_get_contents("/var/www/html/picture/picture-$timestamp.jpg"));
  }
  public static function recordVideo(){
    shell_exec("/opt/vc/bin/raspivid -t 0 -w 1280 -h 720 -hf -ih -fps 60 -o /var/www/html/recording/video-".time().".h264 | echo 'test' & disown");
    $GLOBALS["SETTINGS"]["pid"] = Helper::getPID();
    $GLOBALS["SETTINGS"]["state"]["running"] = Helper::is_process_running($GLOBALS["SETTINGS"]["pid"]);
  }
  public static function stopVideo(){
    shell_exec("kill ". $GLOBALS["SETTINGS"]["pid"]);
    Helper::setIsRunning();
    $GLOBALS["SETTINGS"]["pid"] = 0;
  }
 
}