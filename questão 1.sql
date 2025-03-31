-- Tabela de Clientes
CREATE TABLE clientes (
    id_cliente SERIAL PRIMARY KEY,                    -- Identificador único, auto-incrementado
    nome VARCHAR(100) NOT NULL,                       -- Nome do cliente, obrigatório
    data_cadastro DATE DEFAULT CURRENT_DATE           -- Data de cadastro, padrão é hoje
);

-- Tabela de Produtos
CREATE TABLE produtos (
    id_produto SERIAL PRIMARY KEY,                    -- Identificador único, auto-incrementado
    nome VARCHAR(100) NOT NULL,                       -- Nome do produto, obrigatório
    categoria VARCHAR(50),                            -- Categoria do produto (opcional)
    preco NUMERIC(10, 2) NOT NULL CHECK (preco > 0)   -- Preço com 2 casas decimais, deve ser positivo
);

-- Tabela de Pedidos
CREATE TABLE pedidos (
    id_pedido SERIAL PRIMARY KEY,                         -- Identificador único do pedido
    data_pedido DATE DEFAULT CURRENT_DATE,                -- Data do pedido, padrão é hoje
    valor_total NUMERIC(12, 2) DEFAULT 0.00,              -- Total do pedido, começa com 0
    id_cliente INT NOT NULL,                              -- Cliente associado ao pedido
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
        ON DELETE CASCADE                                 -- Se o cliente for apagado, seus pedidos também
);

-- Tabela de Itens do Pedido
CREATE TABLE itens_pedido (
    id_item SERIAL PRIMARY KEY,                                   -- Identificador único do item
    id_pedido INT NOT NULL,                                       -- Pedido relacionado
    id_produto INT NOT NULL,                                      -- Produto relacionado
    quantidade INT NOT NULL CHECK (quantidade > 0),               -- Quantidade, deve ser positiva
    preco_unitario NUMERIC(10, 2) NOT NULL CHECK (preco_unitario >= 0), -- Preço da unidade

    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
        ON DELETE CASCADE,                                        -- Apaga itens se o pedido for excluído
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
        ON DELETE CASCADE                                         -- Apaga itens se o produto for excluído
);

