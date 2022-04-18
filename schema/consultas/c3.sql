/**
 * Seleciona nome de todos os filmes que receberam um prêmio do Oscar
 * e tiveram nota de avaliação maior que 3
 */
SELECT DISTINCT midia.nome_midia
FROM midia
JOIN filme ON filme.id_midia = midia.id_midia
WHERE midia.id_midia
IN (
    SELECT premiacao.id_midia
    FROM premiacao
    JOIN premio ON premio.id_premio = premiacao.id_premio
    WHERE premio.nome_premio = 'Oscar'
)
AND midia.id_midia
IN (
    SELECT avaliacao.id_midia
    FROM avaliacao
    WHERE avaliacao.nota > 3
);
