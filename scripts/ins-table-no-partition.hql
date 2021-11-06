--Forma de execução do Script
--hive --hiveconf local='hdfs://namenode:8020/user/Cartola/times_ids' --hiveconf tabela=equipe -f ins-table-no-partition.hql

--SET tabela=equipe;
--SET local='hdfs://namenode:8020/user/Cartola/times_ids';

ALTER TABLE stage.${hiveconf:tabela}
  SET LOCATION "${hiveconf:local}";

INSERT INTO TABLE cartola.${hiveconf:tabela}
SELECT t.* FROM stage.${hiveconf:tabela} t;
