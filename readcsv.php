<?php
function readCsv($file)
{
    $data = array();
    try {
        if (($handle = fopen($file, "r")) !== FALSE) {
            while (($row = fgetcsv($handle, 2048, ",")) !== FALSE) {
                $data[]=$row;
            }
            fclose($handle);
        }
    } catch (Exception $e)
    {
        print "ERROR:".$e->printMessage().PHP_EOL;
    }
    return $data;
}
