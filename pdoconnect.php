<?php
function connectDb()
{
    try {
        $dbh = new PDO('mysql:host=localhost;port=3306;dbname=ptoe_worddb', 'root', 'Madan2014', array( PDO::ATTR_PERSISTENT => false));
        return $dbh;
    }
    catch (PDOException $e)
    {
        printDbErr($dbh,$e);
        return NULL;
    }
}
function printDbErrCode($dbh)
{
    print "ERRORCODE:".$dbh->errorCode().PHP_EOL;
}
function printDbErr($dbh,$e)
{
    print "Error!: " . $e->getMessage().PHP_EOL;
    printDbErrCode($dbh);
    #die();
}
?>
