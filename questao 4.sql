WITH vendas_gerais AS (
    SELECT
        ip.id_produto,
        p.nome,
        SUM(ip.quantidade * ip.preco_unitario) AS total_vendas
    FROM itens_pedido ip
    JOIN produtos p ON p.id_produto = ip.id_produto
    JOIN pedidos pd ON pd.id_pedido = ip.id_pedido
    GROUP BY ip.id_produto, p.nome
)
SELECT
    id_produto,
    nome,
    total_vendas
FROM vendas_gerais
ORDER BY total_vendas DESC
LIMIT 5;
