SET hive.exec.dynamic.partition = TRUE;
SET hive.exec.dynamic.partition.mode = NONSTRICT;

TRUNCATE TABLE dw.dim_equipe;

INSERT INTO dw.dim_equipe
SELECT DISTINCT
       id
     , FIRST_VALUE(nome) OVER (PARTITION BY id ORDER BY ano DESC)       AS nome
     , FIRST_VALUE(abreviacao) OVER (PARTITION BY id ORDER BY ano DESC) AS abreviacao
     , FIRST_VALUE(slug) OVER (PARTITION BY id ORDER BY ano DESC)       AS slug
     , CURRENT_DATE()
  FROM cartola.equipe;

TRUNCATE TABLE dw.fact_partida;
 
INSERT INTO TABLE dw.fact_partida PARTITION (ano)
SELECT data
     , home_team
     , away_team
     , NVL(home_score, 0) AS home_score
     , NVL(away_score, 0) AS away_score
     , round
     , CASE WHEN NVL(home_score, 0) = NVL(away_score, 0) THEN 'Empate'
            WHEN NVL(home_score, 0) > NVL(away_score, 0) THEN 'Vitoria Mandante'
            WHEN NVL(home_score, 0) < NVL(away_score, 0) THEN 'Vitoria Visitante'
       END             AS resultado        
     , CURRENT_DATE()  AS dtinclusao      
     , ano        
  FROM cartola.partida;
