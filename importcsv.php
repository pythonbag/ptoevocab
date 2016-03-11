<?php
$cwd=getCwd();
require_once($cwd."/pdoconnect.php");
require_once($cwd."/pdotables.php");
require_once($cwd."/readcsv.php");
function addSynonyms($dbh,$word_id,$synonyms,$pos)
{
    if ($synonyms === "")
    {
        return;
    }
    $syn_array = explode(",",$synonyms);
    #print_r($syn_array);
    foreach ($syn_array as $synonym)
    {
        $synonyms_id=insertSynonym($dbh,$synonym,$word_id,$pos);
    }
}
function addSentence($dbh,$word_id,$sentence,$state,&$pos)
{
    if ($sentence === "")
    {
        return 0;
    }
    if ($pos === "0")
    {
        $pos = partOfSpeech($sentence);
    }
    return insertSentence($dbh,$sentence,$word_id,$state,$pos);
}
function addDefinition($dbh,$word_id,$definition,&$pos)
{
    if ($definition === "")
    {
        return 0;
    }
    if ($pos === "0")
    {
        $pos = partOfSpeech($definition);
    }
    print "POS:$pos:$definition".PHP_EOL;
    return insertDefinition($dbh,$definition,$word_id,"","",$pos);
}
function addSpelling($dbh,$word_id,$spelling,$state)
{
    if ($spelling === "")
    {
         return 0;
    }
    return insertSpelling($dbh,$spelling,$word_id, $state);
}
function importCsv($file)
{
    $data = readCsv($file);
    $dbh=connectDb();
    unset($data[0]);                            // remove csv header
    $word_id=0;
    $pos="0";
    foreach ($data as $key=>$row)
    {
       $word=$row[0];
       if ($word != "")
       {
          #print PHP_EOL."WORD:$word".PHP_EOL;
          $word_id=insertVocabWord($dbh,$word,"10");
          if ($word_id != 0)
          {
              addDefinition($dbh,$word_id,$row[3],$pos="0");
              addSentence($dbh,$word_id,$row[1],"1",$pos);
              addSynonyms($dbh,$word_id,$row[2],$pos);
              addSpelling($dbh,$word_id,$row[4],"1");
              commitTrans($dbh);
          }
          else
          {
              print "WORD_ID:$word_id:$word".PHP_EOL;
          }
       }
       else
       {
          addDefinition($dbh,$word_id,$row[3],$pos);
          addSentence($dbh,$word_id,$row[1],"0",$pos);
          addSynonyms($dbh,$word_id,$row[2],$pos);
          addSpelling($dbh,$word_id,$row[4],"0");
          commitTrans($dbh);
       }
    }
}
$file = $argv[1];
importCsv($file);
