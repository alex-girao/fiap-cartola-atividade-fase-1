DROP DATABASE IF EXISTS stage CASCADE;

CREATE DATABASE IF NOT EXISTS stage;

DROP DATABASE IF EXISTS cartola CASCADE;

CREATE DATABASE IF NOT EXISTS cartola;

DROP TABLE IF EXISTS cartola.jogador;

CREATE TABLE IF NOT EXISTS cartola.jogador
(
  id        INT    COMMENT 'id do jogador'
, apelido   STRING COMMENT 'nome/apelido do jogador'
, clubeid   INT    COMMENT 'id do clube do jogador'
, posicaoid INT    COMMENT 'posição do jogador'
)
PARTITIONED BY (ano INT)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';

DROP TABLE IF EXISTS cartola.lance;

CREATE TABLE IF NOT EXISTS cartola.lance
(
  ID        INT    COMMENT 'id do lance'
, PartidaID INT    COMMENT 'id da partida'
, ClubeID   INT    COMMENT 'id do clube'
, AtletaID  INT    COMMENT 'id do jogador'
, Periodo   STRING COMMENT 'indica o período do lance'
, Momento   INT    COMMENT 'tempo em minutos que o lance ocorreu'
, Tipo      STRING COMMENT 'tipo de scout'
)
PARTITIONED BY (ano INT)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';

DROP TABLE IF EXISTS cartola.partida_id;

CREATE TABLE IF NOT EXISTS cartola.partida_id
(
  ID              INT    COMMENT 'id da partida'
, Rodada          INT    COMMENT 'número da rodada do Brasileirão'
, Casa            INT    COMMENT 'id do time mandante'
, Visitante       INT    COMMENT 'id do time visitante'
, PlacarCasa      INT    COMMENT 'placar do time mandante'
, PlacarVisitante INT    COMMENT 'placar do time visitante'
, Resultado       STRING COMMENT 'indica o time vencedor (casa ou mandante) ou se houve empate'
)
PARTITIONED BY (ano INT)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';

DROP TABLE IF EXISTS cartola.partida;

CREATE TABLE IF NOT EXISTS cartola.partida
(
  id        BIGINT  COMMENT 'Id no Arquivo' 
, game      BIGINT  COMMENT 'ordem da partida'
, round     BOOLEAN COMMENT 'rodada do brasileirão'
, data      STRING  COMMENT 'data e hora da partida'
, home_team STRING  COMMENT 'time mandante e seu estado'
, score     STRING  COMMENT 'placar da partida'
, away_team STRING  COMMENT 'time visitante e seu estado'
, arena     STRING  COMMENT 'nome e localização do estádio'
)
PARTITIONED BY (ano INT)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';

DROP TABLE IF EXISTS cartola.scouts_raw;

CREATE TABLE IF NOT EXISTS cartola.scouts_raw
(
  Atleta        BIGINT  COMMENT 'id do jogador'
, Rodada        BIGINT  COMMENT 'número da rodada do Brasileirão'
, Clube         BIGINT  COMMENT 'clube do jogador'
, Participou    BOOLEAN COMMENT 'indica se o jogador participou ou não'
, Posicao       BOOLEAN COMMENT 'posição do jogador'
, Jogos         BIGINT  COMMENT 'quantidade de jogos que o jogador participou até aquela rodada'
, Pontos        DOUBLE  COMMENT 'pontuação do jogador'
, PontosMedia   DOUBLE  COMMENT 'média da pontuação do jogador'
, Preco         DOUBLE  COMMENT 'preço do jogador'
, PrecoVariacao DOUBLE  COMMENT 'variação de preço'
, Partida       BIGINT  COMMENT 'id da partida'
, Mando         BOOLEAN COMMENT 'indica se o jogador era do time com mando de campo ou não'
, Titular       BOOLEAN COMMENT 'indica se o jogador foi titular ou não'
, Substituido   BOOLEAN COMMENT 'indica se o jogador foi substituído ou não'
, TempoJogado   BOOLEAN COMMENT 'indica a fração de tempo (90 minutos) jogado pelo jogador'
, Nota          DOUBLE  COMMENT 'indica a nota do jogador pela crítica especializada'
, FS            BIGINT  COMMENT 'faltas sofridas'
, PE            BIGINT  COMMENT 'passes errados'
, A             BOOLEAN COMMENT 'assistências'
, FT            BOOLEAN COMMENT 'finalizações na trave'
, FD            BOOLEAN COMMENT 'finalizações defendidas'
, FF            BOOLEAN COMMENT 'finalizações para fora'
, G             BOOLEAN COMMENT 'gols'
, I             BOOLEAN COMMENT 'impedimentos'
, PP            BOOLEAN COMMENT 'pênaltis perdidos'
, RB            BOOLEAN COMMENT 'roubadas de bola'
, FC            BOOLEAN COMMENT 'faltas cometidas'
, GC            BOOLEAN COMMENT 'gols contra'
, CA            BOOLEAN COMMENT 'cartões amarelo'
, CV            BOOLEAN COMMENT 'cartões vermelho'
, SG            BOOLEAN COMMENT 'jogos sem sofrer gols'
, DD            BIGINT  COMMENT 'defesas difíceis'
, DP            BOOLEAN COMMENT 'defesas de pênaltis'
, GS            BIGINT  COMMENT 'gols sofridos'
)
PARTITIONED BY (ano INT)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';

DROP TABLE IF EXISTS stage.partidas;

CREATE TABLE IF NOT EXISTS stage.partidas(
  id bigint,
  game bigint,
  round boolean,
  data string,
  home_team string,
  score string,
  away_team string,
  arena string,
  x string)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "quoteChar"="\"",
  "escapeChar"="\\")
STORED AS TEXTFILE
LOCATION 'hdfs://namenode:8020/user/hive/warehouse/stage.db/partida'
TBLPROPERTIES ('skip.header.line.count'='1');

LOAD DATA INPATH 'hdfs://namenode:8020/user/Cartola/2014/2014_partidas.csv' OVERWRITE INTO TABLE stage.partidas;

hive -e --Executa Comando
hive -f --Executa Script

CREATE EXTERNAL TABLE IF NOT EXISTS stage.partidas(
  id bigint,
  game bigint,
  round boolean,
  data string,
  home_team string,
  score string,
  away_team string,
  arena string,
  x string)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "quoteChar"="\"",
  "escapeChar"="\\")
STORED AS TEXTFILE
LOCATION 'hdfs://namenode:8020/user/Cartola/2014/2014_jogadores'
TBLPROPERTIES ('skip.header.line.count'='1');





load data inpath 'hdfs://namenode:8020/user/Cartola/2014/2014_jogadores.csv' INTO TABLE cartola.jogador
;
https://github.com/henriquepgomide/caRtola/archive/refs/heads/master.zip

TRUNCATE TABLE cartola.jogador
SELECT * FROM cartola.jogador WHERE id IS NOT NULL

SHOW CREATE TABLE cartola.jogador

DROP TABLE cartola.jogador

CREATE TABLE cartola.jogador
(
  id INT
, apelido STRING
, clubeid INT
, posicaoid INT
)
PARTITIONED BY (ano INT)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','

