<?php
$path = './slim/slim/';
$cwd=getCwd();
set_include_path(get_include_path() . PATH_SEPARATOR . $path);
require_once('Slim/Slim.php');
require_once($cwd."/pdoconnect.php");
require_once($cwd."/pdotables.php");
\Slim\Slim::registerAutoloader();
$app = new \Slim\Slim();
$app->get('/api_v1/vocabWord/:vocab_name/', function ($vocab_name) {
    $dbh=connectDb();
    $result=selectVocabWordByName($dbh,$vocab_name);
    print json_encode($result);
});
$app->get('/api_v1/word/:vocab_id/', function ($vocab_id) {
    $dbh=connectDb();
    $result=selectVocabWordById($dbh,$vocab_id);
    print json_encode($result);
});
$app->get('/api_v1/definitions/:definition_id/', function ($definition_id) {
    $dbh=connectDb();
    $result=selectDefinitionsById($dbh,$definition_id);
    print json_encode($result);
});
$app->get('/api_v1/sentences/:sentence_id/', function ($sentence_id) {
    $dbh=connectDb();
    $result=selectSentencesById($dbh,$sentence_id);
    print json_encode($result);
});
$app->get('/api_v1/spellings/:spelling_id/', function ($spelling_id) {
    $dbh=connectDb();
    $result=selectSpellingsById($dbh,$spelling_id);
    print json_encode($result);
});
$app->get('/api_v1/synonyms/:synonym_id/', function ($synonym_id) {
    $dbh=connectDb();
    $result=selectSynonymsById($dbh,$synonym_id);
    print json_encode($result);
});
// Get request object
#$req = $app->request;
//Get root URI
#$rootUri = $req->getRootUri();
#print "URI:".$rootUri.PHP_EOL;

//Get resource URI
#$resourceUri = $req->getResourceUri();
#print "RESOURCE:".$resourceUri.PHP_EOL;
$app->run();

