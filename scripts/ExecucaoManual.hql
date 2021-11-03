hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2014/2014_partidas' --hiveconf tabela=partida --hiveconf ano=2014 -f ins-table.hql
hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2014/2014_jogadores' --hiveconf tabela=jogador --hiveconf ano=2014 -f ins-table.hql
hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2014/2014_scouts_raw' --hiveconf tabela=scouts_raw --hiveconf ano=2014 -f ins-table.hql
hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2014/2014_partidas_ids' --hiveconf tabela=partida_id --hiveconf ano=2014 -f ins-table.hql
hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2014/2014_lances' --hiveconf tabela=lance --hiveconf ano=2014 -f ins-table.hql
hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2014/2014_times' --hiveconf tabela=equipe --hiveconf ano=2014 -f ins-table.hql

hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2015/2015_partidas' --hiveconf tabela=partida --hiveconf ano=2015 -f ins-table.hql
hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2015/2015_jogadores' --hiveconf tabela=jogador --hiveconf ano=2015 -f ins-table.hql
hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2015/2015_scouts_raw' --hiveconf tabela=scouts_raw --hiveconf ano=2015 -f ins-table.hql
hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2015/2015_partidas_ids' --hiveconf tabela=partida_id --hiveconf ano=2015 -f ins-table.hql
hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2015/2015_times' --hiveconf tabela=equipe --hiveconf ano=2015 -f ins-table.hql

hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2016/2016_partidas' --hiveconf tabela=partida --hiveconf ano=2016 -f ins-table.hql
hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2016/2016_jogadores' --hiveconf tabela=jogador --hiveconf ano=2016 -f ins-table.hql
hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2016/2016_scouts_raw' --hiveconf tabela=scouts_raw --hiveconf ano=2016 -f ins-table.hql
hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2016/2016_partidas_ids' --hiveconf tabela=partida_id --hiveconf ano=2016 -f ins-table.hql
hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2016/2016_times' --hiveconf tabela=equipe --hiveconf ano=2016 -f ins-table.hql

hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2017/2017_partidas' --hiveconf tabela=partida --hiveconf ano=2017 -f ins-table.hql
hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2017/2017_jogadores' --hiveconf tabela=jogador --hiveconf ano=2017 -f ins-table.hql
hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2017/2017_scouts_raw' --hiveconf tabela=scouts_raw --hiveconf ano=2017 -f ins-table.hql
hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2017/2017_times' --hiveconf tabela=equipe --hiveconf ano=2017 -f ins-table.hql
hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2017/2017_tabela' --hiveconf tabela=tabela --hiveconf ano=2017 -f ins-table.hql
hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2017/2017_dados_agregados'

hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2018/2018_partidas' --hiveconf tabela=partida --hiveconf ano=2018 -f ins-table.hql
hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2018/2018_jogadores' --hiveconf tabela=jogador --hiveconf ano=2018 -f ins-table.hql
hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2018/2018_tabelas' --hiveconf tabela=tabela --hiveconf ano=2018 -f ins-table.hql
hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2018/2018_agregados'
hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2018/2018-rodada'
hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2018/2018-medias-jogadores'

hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2019/2019_partidas' --hiveconf tabela=partida --hiveconf ano=2019 -f ins-table.hql
hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2019/2019-rodada'
hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2019/2019-medias-jogadores'
hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2019/inicio-0'
hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2019/team-features'
hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2019/team-rankings'

hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2020/2020_partidas' --hiveconf tabela=partida --hiveconf ano=2020 -f ins-table.hql
hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2020/2020-rodada'
hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2020/2020-medias-jogadores'
hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2020/team-features'
hive --hiveconf local='hdfs://namenode:8020/user/Cartola/2020/team-rankings'
hive --hiveconf local='hdfs://namenode:8020/user/Cartola/desafio_valorizacao'
