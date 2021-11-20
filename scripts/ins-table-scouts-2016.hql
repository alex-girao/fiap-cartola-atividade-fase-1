SET hive.exec.dynamic.partition = TRUE;
SET hive.exec.dynamic.partition.mode = NONSTRICT;

ALTER TABLE stage.${hiveconf:tabela}${hiveconf:versao}
  SET LOCATION "${hiveconf:local}";

INSERT INTO TABLE cartola.${hiveconf:tabela} PARTITION (ano)
SELECT Atleta       
     , Rodada       
     , Clube        
     , CASE WHEN Participou = 'TRUE' THEN 1 ELSE 0 END AS participou
     , NULL AS Posicao      
     , NULL AS Jogos        
     , Pontos       
     , PontosMedia  
     , Preco        
     , PrecoVariacao
     , NULL AS Partida      
     , NULL AS Mando        
     , NULL AS Titular      
     , NULL AS Substituido  
     , NULL AS TempoJogado  
     , NULL AS Nota         
     , FS           
     , PE           
     , A            
     , FT           
     , FD           
     , FF           
     , G            
     , I            
     , PP           
     , RB           
     , FC           
     , GC           
     , CA           
     , CV           
     , SG           
     , DD           
     , DP           
     , GS
	 , ${hiveconf:ano} 
  FROM stage.${hiveconf:tabela}${hiveconf:versao};
