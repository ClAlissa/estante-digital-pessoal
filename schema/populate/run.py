# Melissa [ator, diretor, filme, livro, manga, serie, midia] 
# Igor [premiacao, usuario, episodio, lista] 
# Claudia [personagem, temporada, midia_generos, amizade]
# Willian [avaliacao, direcao, participacao_ator, participacao_personagem, pertence]

entidades_fortes = [
    "ator",
    "diretor",
    "filme",
    "livro",
    "manga",
    "midia",
    "premiacao",
    "serie",
    "usuario"
]

entidades_fracas = [
    "episodio",
    "lista",
    "personagem",
    "temporada"
]

atributos = [
    "midia_generos"
]

relacoes = [
    "amizade",
    "avaliacao",
    "direcao",
    "participacao_ator",
    "participacao_personagem",
    "pertence"
]

import psycopg2
import os
from dotenv import load_dotenv

load_dotenv()

con = psycopg2.connect(
    host=os.getenv("hostname"),
    port=os.getenv("port"),
    dbname=os.getenv("database"),
    user=os.getenv("user"),
    password=os.getenv("password")
)

cur = con.cursor()

def execute(files):
    global cur
    for f in files:
        f = f + ".sql"
        with open(f, "r") as file:
            statements = file.read()
            if not statements:
                continue 
            cur.execute(statements)

execute(entidades_fortes)
execute(entidades_fracas)
execute(atributos)
execute(relacoes)

con.commit()
con.close()