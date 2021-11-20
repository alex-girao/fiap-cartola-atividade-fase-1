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
  FROM cartola.equipe
 UNION ALL 
SELECT -1 id
     , 'Não Identificado' AS nome
     , 'Não Identificado' AS abreviacao
     , 'Não Identificado' AS slug
     , CURRENT_DATE();

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

TRUNCATE TABLE dw.dim_jogador;

WITH qry AS (SELECT jogador.id
             , jogador.apelido
             , CASE posicaoid
                  WHEN  1 THEN 'Goleiro'
                  WHEN  2 THEN 'Lateral'
                  WHEN  3 THEN 'Zagueiro'
                  WHEN  4 THEN 'Meia'
                  WHEN  5 THEN 'Atacante'
                  WHEN  6 THEN 'Técnico'
                  ELSE         'Sem Posição' 
               END AS posicaoid
             , ano  
          FROM cartola.jogador
         WHERE jogador.ano <= 2017
         UNION ALL    
        SELECT jogador.id id
             , jogador.apelido
             , posicaoid
             , ano  
          FROM cartola.jogador
         WHERE ano = 2018
         UNION ALL
         SELECT DISTINCT
                player_id
              , player_nickname
              , CASE player_position
                   WHEN 'ata' THEN 'Atacante'
                   WHEN 'gol' THEN 'Goleiro'
                   WHEN 'lat' THEN 'Lateral'
                   WHEN 'mei' THEN 'Meia'
                   WHEN 'zag' THEN 'Zagueiro'
                END   
              , ano
           FROM cartola.media_jogador
         UNION ALL    
        SELECT -1 id
             , 'Não Identificado' apelido
             , 'Não Identificado' posicaoid
             , 2020 ano)
INSERT INTO dw.dim_jogador
SELECT DISTINCT 
       id
     , FIRST_VALUE(apelido) OVER (PARTITION BY id ORDER BY ano) AS apelido
     , FIRST_VALUE(posicaoid) OVER (PARTITION BY id ORDER BY ano) AS posicaoid
     , CURRENT_DATE()
  FROM qry;
  
TRUNCATE TABLE dw.fact_scouts_raw;

INSERT INTO TABLE dw.fact_scouts_raw PARTITION (ano)
SELECT DISTINCT
       NVL(dim_jogador.id, -1) AS atleta
     , FIRST_VALUE(pontosmedia) OVER (PARTITION BY atleta, ano ORDER BY rodada DESC) AS pontosmedia
     , FIRST_VALUE(NVL(dim_equipe.id, -1)) OVER (PARTITION BY atleta, ano ORDER BY rodada DESC) AS clube
     , CURRENT_DATE()
     , ano
  FROM cartola.scouts_raw
  LEFT JOIN dw.dim_jogador
    ON scouts_raw.atleta = dim_jogador.id
  LEFT JOIN dw.dim_equipe
    ON scouts_raw.clube = dim_equipe.id
 WHERE pontosmedia <> 0
 UNION ALL
SELECT NVL(dim_jogador.id, -1) AS player_id
     , score_mean AS pontosmedia
     , NVL(dim_equipe.id, -1)  AS player_team
     , CURRENT_DATE()
     , ano
  FROM cartola.media_jogador
  LEFT JOIN dw.dim_jogador
    ON media_jogador.player_id = dim_jogador.id
  LEFT JOIN dw.dim_equipe
    ON media_jogador.player_team = dim_equipe.id;
