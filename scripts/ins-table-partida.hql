SET hive.exec.dynamic.partition = TRUE;
SET hive.exec.dynamic.partition.mode = NONSTRICT;

ALTER TABLE stage.${hiveconf:tabela}${hiveconf:versao}
  SET LOCATION "${hiveconf:local}";

INSERT INTO TABLE cartola.${hiveconf:tabela} PARTITION (ano)
SELECT DISTINCT
       CASE WHEN LENGTH(data) > 10 THEN SUBSTR(data, 7, 4)||'-'||SUBSTR(data, 4, 2)||'-'||SUBSTR(data, 1, 2) ELSE data END AS data
     , dph.id              AS home_team
     , dpa.id              AS away_team
     , SUBSTR(score, 1, 1) AS home_score
     , SUBSTR(score, -1)   AS away_score
     , round
	 , ${hiveconf:ano} 
  FROM stage.${hiveconf:tabela}${hiveconf:versao} partida
 INNER JOIN cartola.equipe_depara dph
    ON partida.home_team = dph.nome_cbf
 INNER JOIN cartola.equipe_depara dpa
    ON partida.away_team = dpa.nome_cbf;
