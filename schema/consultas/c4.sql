/**
 * Selecionar os nomes de todas as listas do usuário com nome Fatima
 * que possuem pelo menos uma série de comédia com o ator Adam Sandler
 */
SELECT lista.nome_lista
FROM lista
JOIN usuario ON usuario.nome_usuario = lista.nome_usuario
WHERE usuario.nome_usuario = 'Fatima'
AND lista.nome_lista
IN (
    SELECT pertence.nome_lista 
    FROM pertence
    JOIN midia ON midia.id_midia = pertence.id_midia
    JOIN serie ON midia.id_midia = serie.id_midia
    JOIN midia_generos ON midia_generos.id_midia = midia.id_midia
    WHERE midia_generos.genero = 'Comédia'
    AND midia.id_midia 
    IN (
        SELECT personagem.id_midia
        FROM personagem
        JOIN ator ON ator.id_ator = personagem.id_ator
        WHERE ator.nome_ator = 'Adam Sandler'
    )
);






