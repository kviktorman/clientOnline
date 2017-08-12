<?php

    if($_SERVER['REQUEST_METHOD'] == "POST"){
        $messageRequest = json_decode(file_get_contents('php://input'), true);
        $timestamp = date("Y.m.d H:i:s");
        $logFile = "./logs/kristina.out";

        switch($messageRequest['messageName']){
            case "Identification":

                $string = "Time: ".$timestamp.", HW: ".$messageRequest['idHW'].", MAC: ".$messageRequest['addressMAC'].", IP: ".$messageRequest['addressIP']."\n";
                
                $tempLocation ="./logs/";
                $context = stream_context_create();
                $fp = fopen($logFile, 'r', 1, $context);
                $tmpname = md5("tempname");

                file_put_contents($tempLocation.$tmpname, $string);
                file_put_contents($tempLocation.$tmpname, $fp, FILE_APPEND);
                fclose($fp);
                unlink($logFile);
                rename($tempLocation.$tmpname, $logFile);

                $messageResponse = array("status" => 0, "msg" => "Done");
                break;
            default:
                $messageResponse = array("status" => -1, "msg" => "Sorry No message response for this request");
                break;
        }

        chmod($logFile, 0766);
    }else{
        $messageResponse = array("status" => -1, "msg" => "Request method not accepted only POST messages are accepted!");
    }

    /* Output header */
    header("Access-Control-Allow-Origin: *");
    header("Access-Control-Allow-Headers: *");
    header('Content-type: application/json');

    echo json_encode($messageResponse);
    exit();

?>