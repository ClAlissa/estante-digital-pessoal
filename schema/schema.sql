/**
 * PART_OF_URI indica que essa coluna poderá ser referenciada
 * no sistema a partir da URI. Por esse motivo, é necessário
 * que a coluna tenha um padrão aceitável para uma URI.
 *
 * Exemplo: https://edp.willpinha.com.br/nome_usuario/nome_lista
 */
CREATE DOMAIN PART_OF_URI AS CHAR(20)
CHECK PART_OF_URI LIKE "\w+";

/* -------------------------------------------------- */

CREATE TABLE usuario {
    nome_usuario PART_OF_URI,
    email CHAR(30) NOT NULL, 
    senha CHAR(30) NOT NULL,
    PRIMARY KEY(nome_usuario)
};

/* -------------------------------------------------- */

CREATE TABLE lista {
    nome_lista PART_OF_URI,
    nome_usuario PART_OF_URI,
    eh_favorita BOOLEAN,
    PRIMARY KEY(nome_lista, nome_usuario),
    FOREIGN KEY(nome_usuario) REFERENCES usuario(nome_usuario)
};

/* -------------------------------------------------- */

CREATE TABLE amizade {
    nome_usuario_env PART_OF_URI,
    nome_usuario_rec PART_OF_URI,
    data_inicio DATE NOT NULL DEFAULT CURRENT_DATE,
    PRIMARY KEY(nome_usuario_env, nome_usuario_rec),
    FOREIGN KEY(nome_usuario_env) REFERENCES usuario(nome_usuario),
    FOREIGN KEY(nome_usuario_rec) REFERENCES usuario(nome_usuario)
};

/* -------------------------------------------------- */

CREATE TABLE midia {
    id_midia INTEGER,
    nome_midia CHAR(30),
    data_lanc DATE NOT NULL,
    resumo VARCHAR(255)
};

/* -------------------------------------------------- */

CREATE TABLE pertence {
    nome_usuario PART_OF_URI,
    nome_lista PART_OF_URI,
    id_midia INTEGER,
    PRIMARY KEY(nome_usuario, nome_lista, id_midia),
    FOREIGN KEY(nome_usuario) REFERENCES usuario(nome_usuario),
    FOREIGN KEY(nome_lista) REFERENCES lista(nome_lista),
    FOREIGN KEY(id_midia) REFERENCES midia(id_midia)
};

/* -------------------------------------------------- */

CREATE DOMAIN NOTA_0_5 AS INTEGER
CHECK (NOTA_0_5 >= 0 AND NOTA_0_5 <= 5);

CREATE TABLE avaliacao {
    nome_usuario PART_OF_URI,
    id_midia INTEGER,
    nota NOTA_0_5,
    resenha VARCHAR(255),
    PRIMARY KEY(nome_usuario, id_midia),
    FOREIGN KEY(nome_usuario) REFERENCES usuario(nome_usuario),
    FOREIGN KEY(id_midia) REFERENCES midia(id_midia)
};

/* -------------------------------------------------- */

