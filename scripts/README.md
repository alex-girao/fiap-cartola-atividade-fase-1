<b>cria-bd-tables.hql</b><br>
Este será o primeiro script a ser executado, cria os bancos de dados (Stage, Cartola e DW) e as suas respectivas tabelas. <br>
<br>
<b>ingest-hive.sh</b><br>
Este script é responsável pela ingestão dos dados nas tabela do banco de dados <b>Cartola</b>.<br>
<br>
<b>ins-table.hql</b> <br>
Este script será utilizada para fazer a carga das tabelas Stage (origem) para as tabelas do Banco Cartola. <br>
<br>
<b>ins-table-partida.hql</b><br>
Este script será utilizada para fazer a carga das tabelas <b>partidas</b> da Stage (origem) para as tabelas do Banco Cartola. <br>
<br>
<b>ins-table-no-partition.hql</b><br>
Este script será utilizada para fazer a carga das tabelas Stage (origem) para as tabelas do Banco Cartola sem Particionamento. <br>
<br>
<b>insert-dw.hql</b><br>
Este script insere os dados nas tabelas do Data Warehouse (DW) <br>
