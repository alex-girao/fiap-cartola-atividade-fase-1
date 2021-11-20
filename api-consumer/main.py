import requests
import os

baseUrl = "https://api.cartolafc.globo.com/"
baseFolder = "../cartola-data-files/2021/"
endpoints = [
    {'url': 'clubes', 'name_file': 'clubes'},
    {'url': 'ligas', 'name_file': 'ligas'},
    {'url': 'rodadas', 'name_file': 'rodadas'},
    {'url': 'partidas', 'name_file': 'partidas'},
    {'url': 'atletas/mercado', 'name_file': 'atletas'}
]
# incluir dados das rodadas
# https://api.cartolafc.globo.com/partidas/[rodada]

# pasta base
if not os.path.exists(baseFolder):
    os.makedirs(baseFolder)
# requisicao API
for item in endpoints:
    response = requests.get(baseUrl + item['url'])
    print(response.json())
    # pasta
    folder = baseFolder + '2021_'+item['name_file']+'/'
    if not os.path.exists(folder):
        os.makedirs(folder)
    # criando arquivo
    file = folder+item['name_file']+'.json'
    with open(file, 'w') as f:
        f.write(response.text)
