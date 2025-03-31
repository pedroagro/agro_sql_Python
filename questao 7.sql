WITH valor_calculado_por_pedido AS (
    SELECT
        ip.id_pedido,
        SUM(ip.quantidade * ip.preco_unitario) AS valor_calculado
    FROM itens_pedido ip
    GROUP BY ip.id_pedido
)

SELECT
    p.id_pedido,
    ROUND(p.valor_total, 2) AS valor_total_registrado,
    ROUND(v.valor_calculado, 2) AS valor_calculado
FROM pedidos p
JOIN valor_calculado_por_pedido v ON p.id_pedido = v.id_pedido
WHERE ROUND(p.valor_total, 2) <> ROUND(v.valor_calculado, 2);
