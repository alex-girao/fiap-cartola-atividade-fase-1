--Quantos registros há na tabela por ano?
SELECT ano
     , COUNT(*) AS qt_registros
  FROM dw.fact_partida
 GROUP BY ano;

--Quantas equipes únicas mandantes existem?
SELECT COUNT(DISTINCT home_team) qtd_equipes_unicas
  FROM dw.fact_partida;

--Quantas vezes as equipes mandantes saíram vitoriosas?
--Quantas vezes as equipes visitantes saíram vitoriosas?
--Quantas partidas resultaram em empate?
SELECT resultado 
     , COUNT(1) qtd
  FROM dw.fact_partida
 GROUP BY resultado;

--Melhores Jogadores por Ano
 SELECT DISTINCT
       ano
     , FIRST_VALUE(dim_jogador.apelido) OVER (PARTITION BY ano ORDER BY fact_scouts_raw.pontosmedia DESC)         AS apelido
     , FIRST_VALUE(fact_scouts_raw.pontosmedia) OVER (PARTITION BY ano ORDER BY fact_scouts_raw.pontosmedia DESC) AS pontosmedia
     , FIRST_VALUE(dim_equipe.nome) OVER (PARTITION BY ano ORDER BY fact_scouts_raw.pontosmedia DESC)             AS nome     
  FROM dw.fact_scouts_raw
 INNER JOIN dw.dim_equipe
    ON fact_scouts_raw.equipeid = dim_equipe.id
 INNER JOIN dw.dim_jogador
    ON fact_scouts_raw.atletaid = dim_jogador.id
 ORDER BY ano;    

--Melhores Jogadores Geral (Top 10)
SELECT dim_jogador.apelido
     , dim_equipe.nome
     , SUM(fact_scouts_raw.pontosmedia) AS pontosmedia
  FROM dw.fact_scouts_raw
 INNER JOIN dw.dim_equipe
    ON fact_scouts_raw.equipeid = dim_equipe.id
 INNER JOIN dw.dim_jogador
    ON fact_scouts_raw.atletaid = dim_jogador.id
 GROUP BY dim_jogador.apelido
        , dim_equipe.nome
 ORDER BY pontosmedia DESC
 LIMIT 10;

--Qual o Time Ideal (Por ano Baseado nos Scouts dos Jogadores)
SELECT *
  FROM (SELECT ano
             , nome
             , pontosmedia
             , RANK() OVER (PARTITION BY ano ORDER BY pontosmedia DESC) AS rank
          FROM (SELECT fact_scouts_raw.ano
                     , dim_equipe.nome
                     , SUM(fact_scouts_raw.pontosmedia) AS pontosmedia
                  FROM dw.fact_scouts_raw
                 INNER JOIN dw.dim_equipe
                    ON fact_scouts_raw.equipeid = dim_equipe.id
                 INNER JOIN dw.dim_jogador
                    ON fact_scouts_raw.atletaid = dim_jogador.id
                 WHERE dim_equipe.nome != 'Nao Identificado'
                 GROUP BY fact_scouts_raw.ano
                        , dim_equipe.nome) qry) qry1
 WHERE rank <= 5
