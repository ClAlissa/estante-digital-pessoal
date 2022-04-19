/*
 * Mostrar o nome de todas as listas de midias dos usuarios existentes que tenham pelo
 * menos um filme e um livro com o mesmo nome e ambos sejam uma saga. Ou seja, o livro faz
 * parte de uma sequencia de livros que possue uma mesma narrativa, e o filme é uma reprodução
 * do livro. (e.g "Harry Potter e a Pedra Filosofal" tem o livro e o filme, e faz parte da
 * saga "Harry Potter").
*/

SELECT lista.nome_lista
FROM lista, pertence
WHERE lista.nome_usuario = pertence.nome_usuario AND
lista.nome_lista = pertence.nome_lista AND pertence.id_midia IN (
    SELECT m1.id_midia
    FROM filme, midia m1
    WHERE filme.id_midia = m1.id_midia AND
    filme.eh_sequencia = TRUE AND m1.nome_midia IN (
        SELECT m2.nome_midia
        FROM livro, midia m2
        WHERE livro.id_midia = m2.id_midia AND
        livro.eh_saga = TRUE)
);