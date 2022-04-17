/**
 * PART_OF_URI indica que essa coluna poderá ser referenciada
 * no sistema a partir da URI. Por esse motivo, é necessário
 * que a coluna tenha um padrão aceitável para uma URI.
 * 
 * Exemplo: https://edp.willpinha.com.br/nome_usuario/nome_lista
 */
CREATE DOMAIN PART_OF_URI AS CHAR(20)
CHECK (VALUE ~* '\w+');

/* -------------------------------------------------- */

CREATE TABLE usuario (
    nome_usuario PART_OF_URI,
    email CHAR(30) NOT NULL,
    senha CHAR(30) NOT NULL,
    PRIMARY KEY(nome_usuario)
);

/* -------------------------------------------------- */

CREATE TABLE lista (
    nome_lista PART_OF_URI UNIQUE,
    nome_usuario PART_OF_URI,
    eh_favorita BOOLEAN,
    PRIMARY KEY(nome_lista, nome_usuario),
    FOREIGN KEY(nome_usuario) REFERENCES usuario(nome_usuario)
);

/* -------------------------------------------------- */

CREATE TABLE amizade (
    nome_usuario_env PART_OF_URI,
    nome_usuario_rec PART_OF_URI,
    data_inicio DATE NOT NULL DEFAULT CURRENT_DATE,
    PRIMARY KEY(nome_usuario_env, nome_usuario_rec),
    FOREIGN KEY(nome_usuario_env) REFERENCES usuario(nome_usuario),
    FOREIGN KEY(nome_usuario_rec) REFERENCES usuario(nome_usuario)
);

/* -------------------------------------------------- */

CREATE TABLE midia (
    id_midia INT NOT NULL GENERATED ALWAYS AS IDENTITY,
    nome_midia CHAR(60),
    data_lanc DATE NOT NULL,
    resumo VARCHAR(600),
    PRIMARY KEY(id_midia)
);

/* -------------------------------------------------- */

CREATE TABLE midia_generos (
    genero CHAR(30) NOT NULL,
    id_midia INTEGER,
    PRIMARY KEY(genero, id_midia),
    FOREIGN KEY(id_midia) REFERENCES midia(id_midia)
);

/* -------------------------------------------------- */

CREATE TABLE pertence (
    nome_usuario PART_OF_URI,
    nome_lista PART_OF_URI,
    id_midia INTEGER,
    PRIMARY KEY(nome_usuario, nome_lista, id_midia),
    FOREIGN KEY(nome_usuario) REFERENCES usuario(nome_usuario),
    FOREIGN KEY(nome_lista) REFERENCES lista(nome_lista),
    FOREIGN KEY(id_midia) REFERENCES midia(id_midia)
);

/* -------------------------------------------------- */

CREATE DOMAIN NOTA_0_5 AS INTEGER
CHECK (VALUE >= 0 AND VALUE <= 5);

CREATE TABLE avaliacao (
    nome_usuario PART_OF_URI,
    id_midia INTEGER,
    nota NOTA_0_5,
    resenha VARCHAR(255),
    PRIMARY KEY(nome_usuario, id_midia),
    FOREIGN KEY(nome_usuario) REFERENCES usuario(nome_usuario),
    FOREIGN KEY(id_midia) REFERENCES midia(id_midia)
);

/* -------------------------------------------------- */

CREATE TABLE diretor (
    id_dir INT NOT NULL GENERATED ALWAYS AS IDENTITY,
    nome_dir CHAR(30) NOT NULL,
    data_nasc DATE NOT NULL,
    PRIMARY KEY(id_dir)
);

/* -------------------------------------------------- */

CREATE TABLE direcao (
    id_dir INTEGER,
    id_midia INTEGER,
    PRIMARY KEY(id_dir, id_midia),
    FOREIGN KEY(id_dir) REFERENCES diretor(id_dir),
    FOREIGN KEY(id_midia) REFERENCES midia(id_midia)
);

/* -------------------------------------------------- */

CREATE TABLE ator (
    id_ator INT NOT NULL GENERATED ALWAYS AS IDENTITY,
    nome_ator CHAR(30) NOT NULL,
    data_nasc DATE NOT NULL,
    PRIMARY KEY(id_ator)
);

/* -------------------------------------------------- */

CREATE TABLE participacao_ator (
    id_ator INTEGER,
    id_midia INTEGER,
    PRIMARY KEY(id_ator, id_midia),
    FOREIGN KEY(id_ator) REFERENCES ator(id_ator),
    FOREIGN KEY(id_midia) REFERENCES midia(id_midia)
);

/* -------------------------------------------------- */

CREATE TABLE premiacao (
    id_prem INT NOT NULL GENERATED ALWAYS AS IDENTITY,
    id_midia INTEGER,
    id_ator INTEGER,
    nome_prem CHAR(30) NOT NULL,
    categoria CHAR(30) NOT NULL,
    data_prem DATE NOT NULL,
    PRIMARY KEY(id_prem),
    FOREIGN KEY(id_ator) REFERENCES ator(id_ator),
    FOREIGN KEY(id_midia) REFERENCES midia(id_midia)
);

/* -------------------------------------------------- */

CREATE TABLE personagem (
    id_pers INT NOT NULL GENERATED ALWAYS AS IDENTITY,
    id_midia INTEGER,
    id_autor INTEGER,
    nome_pers CHAR(30) NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    PRIMARY KEY(id_pers),
    FOREIGN KEY(id_autor) REFERENCES diretor(id_dir),
    FOREIGN KEY(id_midia) REFERENCES midia(id_midia)
);

/* -------------------------------------------------- */

CREATE TABLE participacao_personagem (
    id_pers INTEGER,
    id_midia INTEGER,
    PRIMARY KEY(id_pers, id_midia),
    FOREIGN KEY(id_pers) REFERENCES personagem(id_pers),
    FOREIGN KEY(id_midia) REFERENCES midia(id_midia)
);

/* -------------------------------------------------- */

CREATE TABLE filme (
    id_midia INTEGER,
    eh_sequencia BOOLEAN NOT NULL,
    classif_etaria CHAR(2) NOT NULL,
    PRIMARY KEY(id_midia),
    FOREIGN KEY(id_midia) REFERENCES midia(id_midia)
);

/* -------------------------------------------------- */

CREATE TABLE livro (
    id_midia INTEGER,
    editora CHAR(30),
    num_edicao INTEGER,
    eh_saga BOOLEAN NOT NULL,
    PRIMARY KEY(id_midia),
    FOREIGN KEY(id_midia) REFERENCES midia(id_midia)
);

/* -------------------------------------------------- */

CREATE TABLE manga (
    id_midia INTEGER,
    tem_adapt BOOLEAN NOT NULL,
    nome_estudio CHAR(30),
    PRIMARY KEY(id_midia),
    FOREIGN KEY(id_midia) REFERENCES midia(id_midia)
);

/* -------------------------------------------------- */

CREATE TABLE serie (
    id_midia INTEGER,
    data_final DATE,
    PRIMARY KEY(id_midia),
    FOREIGN KEY(id_midia) REFERENCES midia(id_midia)
);

/* -------------------------------------------------- */

CREATE TABLE temporada (
    numero_temp INTEGER UNIQUE,
    id_midia INTEGER UNIQUE,
    PRIMARY KEY(numero_temp, id_midia),
    FOREIGN KEY(id_midia) REFERENCES serie(id_midia)
);

/* -------------------------------------------------- */

CREATE TABLE episodio (
    numero_ep INTEGER,
    numero_temp INTEGER,
    id_midia INTEGER,
    PRIMARY KEY(numero_ep, numero_temp, id_midia),
    FOREIGN KEY(id_midia) REFERENCES temporada(id_midia),
    FOREIGN KEY(numero_temp) REFERENCES temporada(numero_temp)
);

/* -------------------------------------------------- */
