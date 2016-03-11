<?php
function execStmt($dbh,$stmt,$parms=array())
{
    try {
        if (empty($parms))
        {
             $result=$stmt->execute();
        }
        else
        {
             $result=$stmt->execute($parms);
        }
        if (!$result)
        {
             print "PDO Error 1.1:".PHP_EOL;
             print_r($stmt->errorInfo());
             print_r($parms);
             return false;
        }
        #print "RESULT:".var_export($result,TRUE).PHP_EOL;
        return $result;
    } catch (PDOException $e) {
        printDbErr($dbh,$e);
        print_r($parms);
        return false;
    }
}
function partOfSpeech($sentence)
{
    if (strpos($sentence,"(n.)") !== FALSE)
    {
        return "1";
    }
    if (strpos($sentence,"(v.)") !== FALSE)
    {
        return "2";
    }
    if (strpos($sentence,"(adj.)") !== FALSE)
    {
        return "3";
    }
    if (strpos($sentence,"(adv.)") !== FALSE)
    {
        return "4";
    }
    return "0";
}
function insertVocabWord($dbh, $word, $level)
{
    try {
        $str="insert into vocab_words(name, level, language, active, creation) values(?,?,?,?,now());";
        $stmt = $dbh->prepare($str);
        $parms=array($word, "$level", "1", "1");
        $result=execStmt($dbh,$stmt,$parms);
        $id=$dbh->lastInsertId();
        unset($stmt);
        return $id;
    } catch (PDOException $e) {
        printDbErr($dbh,$e);
        return 0;
    }
}
function insertDefinition($dbh,$definition, $word_id, $pronunciation, $audio, $pos)
{
    try {
        $str="insert into definitions(definition, word_id, partofspeech, pronunciation, audio_file, active, creation) values(?,?,?,?,?,?,now());";
        $stmt = $dbh->prepare($str);
        $parms=array($definition, $word_id, $pos, $pronunciation, $audio, "1");
        $result=execStmt($dbh,$stmt,$parms);
        $id=$dbh->lastInsertId();
        unset($stmt);
        return $id;
    } catch (PDOException $e) {
        printDbErr($dbh,$e);
        return 0;
    }
}
function insertSentence($dbh,$sentence, $word_id, $state, $pos)
{
    $id=0;
    try {
        $str="insert into sentences(sentence, word_id, partofspeech, state, active, creation) values(?,?,?,?,?,now());";
        $stmt = $dbh->prepare($str);
        $parms=array($sentence, $word_id, $pos, $state, "1");
        $result=execStmt($dbh,$stmt,$parms);
        $id=$dbh->lastInsertId();
        unset($stmt);
        return $id;
    } catch (PDOException $e) {
        printDbErr($dbh,$e);
        return 0;
    }
}
function insertSpelling($dbh,$spelling, $word_id, $state)
{
    $id=0;
    try {
        $str="insert into spellings(spelling, word_id, state, active, creation) values(?,?,?,?,now());";
        $stmt = $dbh->prepare($str);
        $parms=array($spelling, $word_id, $state,"1");
        $result=execStmt($dbh,$stmt,$parms);
        $id=$dbh->lastInsertId();
        unset($stmt);
        return $id;
    } catch (PDOException $e) {
        printDbErr($dbh,$e);
        return 0;
    }
}
function insertSynonym($dbh, $synonym, $word_id, $pos)
{
    $id=0;
    try {
        $str="insert into synonyms(synonym, word_id, partofspeech, active, creation) values(?,?,?,?,now());";
        $stmt = $dbh->prepare($str);
        $parms=array($synonym, $word_id, $pos, "1");
        $result=execStmt($dbh,$stmt,$parms);
        $id=$dbh->lastInsertId();
        unset($stmt);
        return $id;
    } catch (PDOException $e) {
        printDbErr($dbh,$e);
        return 0;
    }
}
function insertVocabList($dbh, $name, $group_id, $active)
{
    $id=0;
    try {
        $str="insert into vocab_list(name, group_id, active, creation) values(?,?,?,now());";
        $stmt = $dbh->prepare($str);
        $parms=array($name, $group_id, $active);
        $result=execStmt($dbh,$stmt,$parms);
        $id=$dbh->lastInsertId();
        unset($stmt);
        return $id;
    } catch (PDOException $e) {
        printDbErr($dbh,$e);
        return 0;
    }
}
function insertVocab($dbh, $vocab_list_id, $word_id, $rank, $active)
{
    $id=0;
    try {
        $str="insert into vocab(vocab_list_id, word_id, rank, active, creation) values(?,?,?,?,now());";
        $stmt = $dbh->prepare($str);
        $parms=array($vocab_list_id, $word_id, $rank, $active);
        $result=execStmt($dbh,$stmt,$parms);
        $id=$dbh->lastInsertId();
        unset($stmt);
        return $id;
    } catch (PDOException $e) {
        printDbErr($dbh,$e);
        return 0;
    }
}
function insertUserVocab($dbh, $user_id, $word_id, $state, $active)
{
    $id=0;
    try {
        $str="insert into user_vocab(user_id, word_id, state, active, creation) values(?,?,?,?,now());";
        $stmt = $dbh->prepare($str);
        $parms=array($user_id, $word_id, $state, $active);
        $result=execStmt($dbh,$stmt,$parms);
        $id=$dbh->lastInsertId();
        unset($stmt);
        return $id;
    } catch (PDOException $e) {
        printDbErr($dbh,$e);
        return 0;
    }
}
function commitTrans($dbh)
{
    try {
        $stmt = $dbh->prepare("commit;");
        $result=execStmt($dbh,$stmt);
    } catch (PDOException $e) {
        printDbErr($dbh,$e);
    }
}
function selectVocabWords($dbh)
{
    try {
        $stmt = $dbh->prepare("select * from vocab_words;");
    
        $stmt->execute();
        // fetch all rows into an array.
        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
        foreach ($rows as $rs) 
        {
            print var_export($rs,TRUE).PHP_EOL;
        }
        unset($stmt);
    } catch (PDOException $e) {
        printDbErr($dbh,$e);
    }
}
function selectVocabWordById($dbh,$word_id)
{
    try {
        $stmt = $dbh->prepare("select * from vocab_words where word_id=$word_id;");
    
        $stmt->execute();
        // fetch all rows into an array.
        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
#        foreach ($rows as $rs) 
#        {
#            print var_export($rs,TRUE).PHP_EOL;
#        }
        unset($stmt);
        return $rows;
    } catch (PDOException $e) {
        printDbErr($dbh,$e);
    }
}
function selectDefinitionById($dbh,$definition_id)
{
    try {
        $stmt = $dbh->prepare("select * from definitions where definition_id=$definition_id;");
    
        $stmt->execute();
        // fetch all rows into an array.
        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
#        foreach ($rows as $rs) 
#        {
#            print var_export($rs,TRUE).PHP_EOL;
#        }
        unset($stmt);
        return $rows;
    } catch (PDOException $e) {
        printDbErr($dbh,$e);
    }
}
function selectVocabWordByName($dbh,$name)
{
    try {
        print "WORD:$name".PHP_EOL;
        $stmt = $dbh->prepare("select * from vocab_words where name='$name';");
    
        $stmt->execute();
        // fetch all rows into an array.
        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
#        foreach ($rows as $rs) 
#        {
#            print var_export($rs,TRUE).PHP_EOL;
#        }
        unset($stmt);
        return $rows;
    } catch (PDOException $e) {
        printDbErr($dbh,$e);
    }
}
function execStoredProc($dbh,$name, $value)
{
    try {
    //initilise the statement
        $stmt = $dbh->prepare("call $name(?);");
        $stmt->bindValue(1, $value);
        if ( ! $stmt->execute() )
        {
            echo "PDO Error 1.1:\n";
            print_r($stmt->errorInfo());
            exit;
        }
        unset($stmt);
    } catch (PDOException $e) {
        printDbErr($dbh,$e);
    }
}
?>
