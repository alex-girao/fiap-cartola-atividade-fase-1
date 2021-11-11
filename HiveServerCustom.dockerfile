FROM fjardim/hive

# copiando arquivos
COPY ./cartola-data-files/ /cartola-data-files/
COPY ./scripts/ /scripts-ingestao/

# RUN bash -c sh ./scripts/ingest-hive.sh &

# Rotulos da imagem
LABEL description="hive_server_custom"
LABEL version="1.0.0"