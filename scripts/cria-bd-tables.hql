DROP DATABASE IF EXISTS stage CASCADE;

CREATE DATABASE IF NOT EXISTS stage;

DROP DATABASE IF EXISTS cartola CASCADE;

CREATE DATABASE IF NOT EXISTS cartola;

DROP DATABASE IF EXISTS dw CASCADE;

CREATE DATABASE IF NOT EXISTS dw;


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
   data        STRING COMMENT 'data e hora da partida'
 , home_team   INT    COMMENT 'time mandante e seu estado' 
 , away_team   INT    COMMENT 'time visitante e seu estado' 
 , home_score  INT    COMMENT 'Quantidade Gols Mandante'
 , away_score  INT    COMMENT 'Quandidade Gols Visitante'
 , round       INT    COMMENT 'rodada do brasileirão'
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
, Participou    INT     COMMENT 'indica se o jogador participou ou não'
, Posicao       INT     COMMENT 'posição do jogador'
, Jogos         BIGINT  COMMENT 'quantidade de jogos que o jogador participou até aquela rodada'
, Pontos        DOUBLE  COMMENT 'pontuação do jogador'
, PontosMedia   DOUBLE  COMMENT 'média da pontuação do jogador'
, Preco         DOUBLE  COMMENT 'preço do jogador'
, PrecoVariacao DOUBLE  COMMENT 'variação de preço'
, Partida       BIGINT  COMMENT 'id da partida'
, Mando         INT     COMMENT 'indica se o jogador era do time com mando de campo ou não'
, Titular       INT     COMMENT 'indica se o jogador foi titular ou não'
, Substituido   INT     COMMENT 'indica se o jogador foi substituído ou não'
, TempoJogado   INT     COMMENT 'indica a fração de tempo (90 minutos) jogado pelo jogador'
, Nota          DOUBLE  COMMENT 'indica a nota do jogador pela crítica especializada'
, FS            BIGINT  COMMENT 'faltas sofridas'
, PE            BIGINT  COMMENT 'passes errados'
, A             INT     COMMENT 'assistências'
, FT            INT     COMMENT 'finalizações na trave'
, FD            INT     COMMENT 'finalizações defendidas'
, FF            INT     COMMENT 'finalizações para fora'
, G             INT     COMMENT 'gols'
, I             INT     COMMENT 'impedimentos'
, PP            INT     COMMENT 'pênaltis perdidos'
, RB            INT     COMMENT 'roubadas de bola'
, FC            INT     COMMENT 'faltas cometidas'
, GC            INT     COMMENT 'gols contra'
, CA            INT     COMMENT 'cartões amarelo'
, CV            INT     COMMENT 'cartões vermelho'
, SG            INT     COMMENT 'jogos sem sofrer gols'
, DD            BIGINT  COMMENT 'defesas difíceis'
, DP            INT     COMMENT 'defesas de pênaltis'
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
  id        BIGINT
, game      BIGINT
, round     INT
, data      STRING
, home_team STRING
, score     STRING
, away_team STRING
, arena     STRING
, x         STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "quoteChar"="\"",
  "escapeChar"="\\")
STORED AS TEXTFILE
LOCATION 'hdfs://namenode:8020/user/Cartola/2014/2014_partidas'
TBLPROPERTIES ('skip.header.line.count'='1');

DROP TABLE IF EXISTS stage.partida2;

CREATE EXTERNAL TABLE IF NOT EXISTS stage.partida2
(
  game      BIGINT
, round     INT
, data      STRING
, home_team STRING
, score     STRING
, away_team STRING
, arena     STRING
, x         STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "escapeChar"="\\")
STORED AS TEXTFILE
LOCATION 'hdfs://namenode:8020/user/Cartola/2018/2018_partidas'
TBLPROPERTIES ('skip.header.line.count'='1');

DROP TABLE IF EXISTS stage.partida3;

CREATE EXTERNAL TABLE IF NOT EXISTS stage.partida3
(
   data        STRING
 , home_team   INT
 , away_team   INT
 , home_score  INT 
 , away_score  INT
 , round       INT
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "escapeChar"="\\")
STORED AS TEXTFILE
LOCATION 'hdfs://namenode:8020/user/Cartola/2020/2020_partidas'
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
, Participou    INT     COMMENT 'indica se o jogador participou ou não'
, Posicao       INT     COMMENT 'posição do jogador'
, Jogos         BIGINT  COMMENT 'quantidade de jogos que o jogador participou até aquela rodada'
, Pontos        DOUBLE  COMMENT 'pontuação do jogador'
, PontosMedia   DOUBLE  COMMENT 'média da pontuação do jogador'
, Preco         DOUBLE  COMMENT 'preço do jogador'
, PrecoVariacao DOUBLE  COMMENT 'variação de preço'
, Partida       BIGINT  COMMENT 'id da partida'
, Mando         INT     COMMENT 'indica se o jogador era do time com mando de campo ou não'
, Titular       INT     COMMENT 'indica se o jogador foi titular ou não'
, Substituido   INT     COMMENT 'indica se o jogador foi substituído ou não'
, TempoJogado   INT     COMMENT 'indica a fração de tempo (90 minutos) jogado pelo jogador'
, Nota          DOUBLE  COMMENT 'indica a nota do jogador pela crítica especializada'
, FS            BIGINT  COMMENT 'faltas sofridas'
, PE            BIGINT  COMMENT 'passes errados'
, A             INT     COMMENT 'assistências'
, FT            INT     COMMENT 'finalizações na trave'
, FD            INT     COMMENT 'finalizações defendidas'
, FF            INT     COMMENT 'finalizações para fora'
, G             INT     COMMENT 'gols'
, I             INT     COMMENT 'impedimentos'
, PP            INT     COMMENT 'pênaltis perdidos'
, RB            INT     COMMENT 'roubadas de bola'
, FC            INT     COMMENT 'faltas cometidas'
, GC            INT     COMMENT 'gols contra'
, CA            INT     COMMENT 'cartões amarelo'
, CV            INT     COMMENT 'cartões vermelho'
, SG            INT     COMMENT 'jogos sem sofrer gols'
, DD            BIGINT  COMMENT 'defesas difíceis'
, DP            INT     COMMENT 'defesas de pênaltis'
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

DROP TABLE IF EXISTS stage.equipe2;

CREATE EXTERNAL TABLE IF NOT EXISTS stage.equipe2
(
   ID         BIGINT COMMENT 'id do time'  
 , Nome       STRING COMMENT 'nome do time' 
 , Abreviacao STRING COMMENT 'abreviação'   
 , Slug       STRING COMMENT 'nome do time '
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ";",
  "escapeChar"="\\")
STORED AS TEXTFILE
LOCATION 'hdfs://namenode:8020/user/Cartola/2017/2017_times'
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
 , PERC   INT
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

DROP TABLE IF EXISTS cartola.media_jogador;

CREATE TABLE IF NOT EXISTS cartola.media_jogador
(
   player_slug                  STRING
 , player_id                    BIGINT
 , player_nickname              STRING
 , player_team                  STRING
 , player_position              STRING
 , price_cartoletas             FLOAT
 , score_mean                   FLOAT
 , score_no_cleansheets_mean    FLOAT
 , diff_home_away_s             FLOAT
 , n_games                      FLOAT
 , score_mean_home              FLOAT
 , score_mean_away              FLOAT
 , shots_x_mean                 FLOAT
 , fouls_mean                   FLOAT
 , DS_mean                      FLOAT
 , PI_mean                      FLOAT
 , A_mean                       FLOAT
 , I_mean                       FLOAT
 , FS_mean                      FLOAT
 , FF_mean                      FLOAT
 , G_mean                       FLOAT
 , DD_mean                      FLOAT
 , status                       STRING  
 , price_diff                   FLOAT
 , last_points                  FLOAT
)
PARTITIONED BY (ano INT)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';

DROP TABLE IF EXISTS stage.media_jogador;

CREATE TABLE IF NOT EXISTS stage.media_jogador
(
   player_slug                  STRING
 , player_id                    BIGINT
 , player_nickname              STRING
 , player_team                  STRING
 , player_position              STRING
 , price_cartoletas             FLOAT
 , score_mean                   FLOAT
 , score_no_cleansheets_mean    FLOAT
 , diff_home_away_s             FLOAT
 , n_games                      FLOAT
 , score_mean_home              FLOAT
 , score_mean_away              FLOAT
 , shots_x_mean                 FLOAT
 , fouls_mean                   FLOAT
 , DS_mean                      FLOAT
 , PI_mean                      FLOAT
 , A_mean                       FLOAT
 , I_mean                       FLOAT
 , FS_mean                      FLOAT
 , FF_mean                      FLOAT
 , G_mean                       FLOAT
 , DD_mean                      FLOAT
 , status                       STRING  
 , price_diff                   FLOAT
 , last_points                  FLOAT
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "escapeChar"="\\")
STORED AS TEXTFILE
LOCATION 'hdfs://namenode:8020/user/Cartola/2020/2020-medias-jogadores'
TBLPROPERTIES ('skip.header.line.count'='1');


DROP TABLE IF EXISTS cartola.equipe_depara;

CREATE TABLE IF NOT EXISTS cartola.equipe_depara
(
   nome_cbf      STRING COMMENT 'nome do time no site da CBF'
 , nome_cartola  STRING COMMENT 'nome do time no Cartola FC'
 , nome_completo STRING COMMENT 'nome do time completo'
 , cod_older     INT    COMMENT 'código do time no Cartola FC até 2017'
 , cod_2017      INT    COMMENT 'código do time no Cartola FC a partir de 2017'
 , cod_2018      INT    COMMENT 'código do time no Cartola FC a partir de 2018'
 , id            INT    COMMENT 'id do time'
 , abreviacao    STRING COMMENT 'Abreviatura do nome' 
 , escudos_60x60 STRING COMMENT 'Link Escudo 60x60'
 , escudos_45x45 STRING COMMENT 'Link Escudo 45x45'
 , escudos_30x30 STRING COMMENT 'Link Escudo 30x30'
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';

DROP TABLE IF EXISTS stage.equipe_depara;

CREATE TABLE IF NOT EXISTS stage.equipe_depara
(
   nome_cbf      STRING COMMENT 'nome do time no site da CBF'
 , nome_cartola  STRING COMMENT 'nome do time no Cartola FC'
 , nome_completo STRING COMMENT 'nome do time completo'
 , cod_older     INT    COMMENT 'código do time no Cartola FC até 2017'
 , cod_2017      INT    COMMENT 'código do time no Cartola FC a partir de 2017'
 , cod_2018      INT    COMMENT 'código do time no Cartola FC a partir de 2018'
 , id            INT    COMMENT 'id do time'
 , abreviacao    STRING COMMENT 'Abreviatura do nome' 
 , escudos_60x60 STRING COMMENT 'Link Escudo 60x60'
 , escudos_45x45 STRING COMMENT 'Link Escudo 45x45'
 , escudos_30x30 STRING COMMENT 'Link Escudo 30x30'
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "escapeChar"="\\")
STORED AS TEXTFILE
LOCATION 'hdfs://namenode:8020/user/Cartola/times_ids'
TBLPROPERTIES ('skip.header.line.count'='1');

DROP TABLE IF EXISTS dw.dim_equipe;

CREATE TABLE IF NOT EXISTS dw.dim_equipe
(
  id         INT    COMMENT 'id da Equipe'
, nome       STRING COMMENT 'nome da Equipe'
, abreviacao STRING COMMENT 'Abreviação do nome da Equipe'
, slug       STRING COMMENT 'Nome da Equipe + Estado'
, dtinclusao DATE   COMMENT 'Data da Inclusão'
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';

DROP TABLE IF EXISTS dw.fact_partida;

CREATE TABLE IF NOT EXISTS dw.fact_partida
(
   data        STRING COMMENT 'data e hora da partida'
 , home_team   INT    COMMENT 'time mandante e seu estado' 
 , away_team   INT    COMMENT 'time visitante e seu estado' 
 , home_score  INT    COMMENT 'Quantidade Gols Mandante'
 , away_score  INT    COMMENT 'Quandidade Gols Visitante'
 , round       INT    COMMENT 'rodada do brasileirão'
 , resultado   STRING COMMENT 'Resultado da Partida'
 , dtinclusao  DATE   COMMENT 'Data da Inclusão'
)
PARTITIONED BY (ano INT)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';
