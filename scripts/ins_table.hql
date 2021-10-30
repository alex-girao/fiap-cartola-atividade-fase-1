--Forma de execução do Script
--hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2014/2014_times' --hiveconf tabela=equipe --hiveconf ano=2014 -f ins-table.hql

--SET tabela=equipe;
--SET local='hdfs://namenode:8020/user/Cartola/2014/2014_times';
--SET ano=2014;

SET hive.exec.dynamic.partition = TRUE;
SET hive.exec.dynamic.partition.mode = NONSTRICT;

ALTER TABLE stage.${hiveconf:tabela}
  SET LOCATION "${hiveconf:local}";

INSERT INTO TABLE cartola.${hiveconf:tabela} PARTITION (ano)
SELECT t.*, ${hiveconf:ano} FROM stage.${hiveconf:tabela} t;
