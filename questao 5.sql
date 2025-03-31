WITH vendas_mensais AS (
    SELECT
        TO_CHAR(data_pedido, 'YYYY-MM') AS mes_ano,
        SUM(valor_total) AS total_vendas
    FROM pedidos
    GROUP BY TO_CHAR(data_pedido, 'YYYY-MM')
)

SELECT
    mes_ano,
    total_vendas,
    
    -- Crescimento percentual em relação ao mês anterior
    ROUND(
        (total_vendas - LAG(total_vendas) OVER (ORDER BY mes_ano)) 
        / NULLIF(LAG(total_vendas) OVER (ORDER BY mes_ano), 0) * 100,
        2
    ) AS crescimento_percentual

FROM vendas_mensais
ORDER BY mes_ano;