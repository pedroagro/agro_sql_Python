INSERT INTO clientes (nome, data_cadastro) VALUES
('João Silva', '2024-01-10'),
('Maria Oliveira', '2024-02-15'),
('Carlos Souza', '2024-03-01'),
('Ana Paula', '2024-03-05'),
('Bruno Mendes', '2024-03-20');
INSERT INTO produtos (nome, categoria, preco) VALUES
('Arroz 5kg', 'Alimentos', 25.90),
('Feijão 1kg', 'Alimentos', 7.80),
('Detergente', 'Limpeza', 2.50),
('Sabonete', 'Higiene', 1.80),
('Óleo de Soja 900ml', 'Alimentos', 6.90);
INSERT INTO pedidos (data_pedido, valor_total, id_cliente) VALUES
('2024-03-21', 0, 1),
('2024-03-22', 0, 2),
('2024-03-23', 0, 3),
('2024-03-24', 0, 4),
('2024-03-25', 0, 5);
-- Pedido 1 (João Silva)
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES
(1, 1, 2, 25.90),
(1, 2, 1, 7.80),
(1, 3, 3, 2.50);

-- Pedido 2 (Maria Oliveira)
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES
(2, 4, 5, 1.80),
(2, 2, 2, 7.80);

-- Pedido 3 (Carlos Souza)
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES
(3, 5, 4, 6.90),
(3, 1, 1, 25.90);

-- Pedido 4 (Ana Paula)
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES
(4, 3, 6, 2.50),
(4, 2, 3, 7.80);

-- Pedido 5 (Bruno Mendes)
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES
(5, 1, 1, 25.90),
(5, 4, 2, 1.80),
(5, 5, 3, 6.90);
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
    EXTRACT(DAY FROM CURRENT_DATE - u.data_ultimo_pedido) AS dias_desde_ultimo_pedido;
    COUNT(p.id_pedido) AS total_pedidos,
    ROUND(AVG(p.valor_total), 2) AS ticket_medio
FROM pedidos p
JOIN ultimos_pedidos u ON p.id_cliente = u.id_cliente
GROUP BY p.id_cliente, u.data_ultimo_pedido
ORDER BY dias_desde_ultimo_pedido;