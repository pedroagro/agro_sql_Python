-- CTE para encontrar a data do último pedido de cada cliente
WITH ultima_compra AS (
    SELECT 
        c.id_cliente,
        c.nome,
        MAX(p.data_pedido) AS data_ultima_compra
    FROM clientes c
    LEFT JOIN pedidos p ON p.id_cliente = c.id_cliente
    GROUP BY c.id_cliente, c.nome
)

-- Consulta final: clientes sem pedido ou com último pedido antes de 6 meses
SELECT
    id_cliente,
    nome
FROM ultima_compra
WHERE data_ultima_compra IS NULL
   OR data_ultima_compra < CURRENT_DATE - INTERVAL '6 months';
