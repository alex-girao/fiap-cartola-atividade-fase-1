<b>ingest-hive.sh</b><br>
<b>Line Command:</b> ./ingest-hive.sh<br>
Este é o unico script a ser executado, é responsável pela ingestão dos dados nas tabela do banco de dados <b>Cartola</b>.<br>
<br>
<b>cria-bd-tables.hql</b><br>
<b>Line Command:</b> hive -f cria-bd-tables.hql<br>
Este será o primeiro script a ser executado, cria os bancos de dados (Stage, Cartola e DW) e as suas respectivas tabelas. <br>
<br>
<b>ins-table.hql</b> (Script utilizado pelo ingest-hive.sh)<br>
Este script será utilizada para fazer a carga das tabelas Stage (origem) para as tabelas do Banco Cartola. <br>
<br>
<b>ins-table-partida.hql</b> (Script utilizado pelo ingest-hive.sh)<br>
Este script será utilizada para fazer a carga das tabelas <b>partidas</b> da Stage (origem) para as tabelas do Banco Cartola. <br>
<br>
<b>ins-table-no-partition.hql</b> (Script utilizado pelo ingest-hive.sh)<br>
Este script será utilizada para fazer a carga das tabelas Stage (origem) para as tabelas do Banco Cartola sem Particionamento. <br>
<br>
<b>insert-dw.hql</b><br>
<b>Line Command:</b> hive -f insert-dw.hql<br>
Este script insere os dados nas tabelas do Data Warehouse (DW) <br>
