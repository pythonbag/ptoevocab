<?php
$cwd=getCwd();
require_once($cwd."/pdoconnect.php");
require_once($cwd."/pdotables.php");
require_once($cwd."/readcsv.php");
function importTestCsv($file)
{
    $data = readCsv($file);
    $dbh=connectDb();
    #unset($data[0]);                            // remove csv header
    $word_id=0;
    $rank=1000;
    $vocabList= array();
    $userList= array();
    foreach ($data as $key=>$row)
    {
       $word=$row[0];
       if ($word === "vocab_list")
       {
          $vocab_list_id=insertVocabList($dbh,$row[1],$row[2],$row[3]);
          if ($vocab_list_id != 0)
          {
              $vocabList[$row[1]]=$vocab_list_id;
              commitTrans($dbh);
          }
          else
          {
              print "$word:$vocab_list_id".PHP_EOL;
          }
       }
       else if ($word === "vocab")
       {
          $vocab_list_id = $vocabList[$row[1]];
          print $row[1].":$vocab_list_id".PHP_EOL;
          print json_encode($vocabList).PHP_EOL;
          $result = selectVocabWordByName($dbh,$row[2]);
          foreach ($result as $rs)
          {
              print json_encode($rs).PHP_EOL;
              $word_id=$rs["word_id"];
              $rank=$rank-1;
              $vocab_id=insertVocab($dbh,$vocab_list_id,$word_id,$rank,$row[3]);
              if ($vocab_id != 0)
              {
                  commitTrans($dbh);
              }
              else
              {
                  print "$word:$vocab_id".PHP_EOL;
              }
          }
       }
       else if ($word === "user")
       {
          $userList[$row[1]] = $row[2];
       }
       else if ($word === "user_vocab")
       {
          $vocab_list_id = $vocabList[$row[1]];
          $user_id = $userList[$row[2]];
          $user_vocab_id=insertUserVocab($dbh,$user_id,$word_id,"1","1");
          if ($user_vocab_id != 0)
          {
              commitTrans($dbh);
          }
          else
          {
              print "$word:$user_vocab_id".PHP_EOL;
          }
       }
    }
}
$file = $argv[1];
importTestCsv($file);
