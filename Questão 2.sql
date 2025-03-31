WITH pedidos_ordenados AS (
    SELECT
        id_cliente,
        id_pedido,
        data_pedido,
        valor_total,
        ROW_NUMBER() OVER (PARTITION BY id_cliente ORDER BY data_pedido DESC) AS rn,
        LAG(data_pedido) OVER (PARTITION BY id_cliente ORDER BY data_pedido DESC) AS pedido_anterior
    FROM pedidos
),
ultimos_pedidos AS (
    SELECT
        id_cliente,
        data_pedido AS data_ultimo_pedido
    FROM pedidos_ordenados
    WHERE rn = 1
)
SELECT
    p.id_cliente,

    -- ✅ Correção: subtração direta entre datas retorna número de dias
    (CURRENT_DATE - u.data_ultimo_pedido) AS dias_desde_ultimo_pedido,

    COUNT(p.id_pedido) AS total_pedidos,
    ROUND(AVG(p.valor_total), 2) AS ticket_medio

FROM pedidos p
JOIN ultimos_pedidos u ON p.id_cliente = u.id_cliente
GROUP BY p.id_cliente, u.data_ultimo_pedido
ORDER BY dias_desde_ultimo_pedido ASC;