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
, x         STRING  COMMENT 'Sem Descrição'
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

DROP TABLE IF EXISTS cartola.equipe;

CREATE TABLE IF NOT EXISTS cartola.equipe
(
   ID         BIGINT COMMENT 'id do time'  
 , Nome       STRING COMMENT 'nome do time' 
 , Abreviacao STRING COMMENT 'abreviação'   
 , Slug       STRING COMMENT 'nome do time '
)
PARTITIONED BY (ano INT)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';

DROP TABLE IF EXISTS stage.jogador;

CREATE EXTERNAL TABLE IF NOT EXISTS stage.jogador
(
  id        INT    COMMENT 'id do jogador'
, apelido   STRING COMMENT 'nome/apelido do jogador'
, clubeid   INT    COMMENT 'id do clube do jogador'
, posicaoid INT    COMMENT 'posição do jogador'
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "quoteChar"="\"",
  "escapeChar"="\\")
STORED AS TEXTFILE
LOCATION 'hdfs://namenode:8020/user/Cartola/2014/2014_jogadores'
TBLPROPERTIES ('skip.header.line.count'='1');

DROP TABLE IF EXISTS stage.lance;

CREATE EXTERNAL TABLE IF NOT EXISTS stage.lance
(
  ID        INT    COMMENT 'id do lance'
, PartidaID INT    COMMENT 'id da partida'
, ClubeID   INT    COMMENT 'id do clube'
, AtletaID  INT    COMMENT 'id do jogador'
, Periodo   STRING COMMENT 'indica o período do lance'
, Momento   INT    COMMENT 'tempo em minutos que o lance ocorreu'
, Tipo      STRING COMMENT 'tipo de scout'
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "escapeChar"="\\")
STORED AS TEXTFILE
LOCATION 'hdfs://namenode:8020/user/Cartola/2014/2014_lances'
TBLPROPERTIES ('skip.header.line.count'='1');

DROP TABLE IF EXISTS stage.partida;

CREATE EXTERNAL TABLE IF NOT EXISTS stage.partida
(
  id bigint,
  game bigint,
  round boolean,
  data string,
  home_team string,
  score string,
  away_team string,
  arena string,
  x string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "quoteChar"="\"",
  "escapeChar"="\\")
STORED AS TEXTFILE
LOCATION 'hdfs://namenode:8020/user/Cartola/2014/2014_partidas'
TBLPROPERTIES ('skip.header.line.count'='1');

DROP TABLE IF EXISTS stage.partida_id;

CREATE EXTERNAL TABLE IF NOT EXISTS stage.partida_id
(
  ID              INT    COMMENT 'id da partida'
, Rodada          INT    COMMENT 'número da rodada do Brasileirão'
, Casa            INT    COMMENT 'id do time mandante'
, Visitante       INT    COMMENT 'id do time visitante'
, PlacarCasa      INT    COMMENT 'placar do time mandante'
, PlacarVisitante INT    COMMENT 'placar do time visitante'
, Resultado       STRING COMMENT 'indica o time vencedor (casa ou mandante) ou se houve empate'
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "escapeChar"="\\")
STORED AS TEXTFILE
LOCATION 'hdfs://namenode:8020/user/Cartola/2014/2014_partidas_ids'
TBLPROPERTIES ('skip.header.line.count'='1');

DROP TABLE IF EXISTS stage.scouts_raw;

CREATE EXTERNAL TABLE IF NOT EXISTS stage.scouts_raw
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
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "escapeChar"="\\")
STORED AS TEXTFILE
LOCATION 'hdfs://namenode:8020/user/Cartola/2014/2014_scouts_raw'
TBLPROPERTIES ('skip.header.line.count'='1');

DROP TABLE IF EXISTS stage.equipe;

CREATE EXTERNAL TABLE IF NOT EXISTS stage.equipe
(
   ID         BIGINT COMMENT 'id do time'  
 , Nome       STRING COMMENT 'nome do time' 
 , Abreviacao STRING COMMENT 'abreviação'   
 , Slug       STRING COMMENT 'nome do time '
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "escapeChar"="\\")
STORED AS TEXTFILE
LOCATION 'hdfs://namenode:8020/user/Cartola/2014/2014_times'
TBLPROPERTIES ('skip.header.line.count'='1');

DROP TABLE IF EXISTS cartola.tabela;

CREATE TABLE IF NOT EXISTS cartola.tabela
(
   Pos    STRING
 , Clube  STRING
 , P      INT
 , J      INT
 , V      INT
 , E      INT
 , D      INT
 , GP     INT
 , GC     INT
 , SG     INT
 , VM     INT
 , VV     INT
 , DM     INT
 , DV     INT
 , CA     INT
 , CV     INT
 , %      INT
)
PARTITIONED BY (ano INT)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';

DROP TABLE IF EXISTS stage.tabela;

CREATE EXTERNAL TABLE IF NOT EXISTS stage.tabela
(
   Pos    STRING
 , Clube  STRING
 , P      INT
 , J      INT
 , V      INT
 , E      INT
 , D      INT
 , GP     INT
 , GC     INT
 , SG     INT
 , VM     INT
 , VV     INT
 , DM     INT
 , DV     INT
 , CA     INT
 , CV     INT
 , PERC   INT
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "escapeChar"="\\")
STORED AS TEXTFILE
LOCATION 'hdfs://namenode:8020/user/Cartola/2017/2017_tabela'
TBLPROPERTIES ('skip.header.line.count'='1');
