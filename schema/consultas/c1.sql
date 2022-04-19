/* 
 * Mostre o nome de todos os filmes e livros que ganharam pelo menos 2 premiações e que sua data de
 * lançamento seja anterior ao dia 01 de Outubro de 2018.
 */

(SELECT midia.nome_midia
FROM midia, filme
WHERE midia.id_midia = filme.id_midia AND filme.id_midia IN
(SELECT premiacao.id_midia
FROM premiacao
WHERE midia.id_midia = premiacao.id_midia AND midia.data_lanc < '2018-10-01'
GROUP BY (premiacao.id_midia)
HAVING COUNT(premiacao.id_midia) > 1))

UNION

(SELECT midia.nome_midia
FROM midia, livro
WHERE midia.id_midia = livro.id_midia AND livro.id_midia IN
(SELECT premiacao.id_midia
FROM premiacao
WHERE midia.id_midia = premiacao.id_midia AND midia.data_lanc < '2018-10-01'
GROUP BY (premiacao.id_midia)
HAVING COUNT(premiacao.id_midia) > 1));