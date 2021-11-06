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
