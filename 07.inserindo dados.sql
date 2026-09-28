-- INSERINDO NOVOS DADOS PARA VALIDAÇÃO 

USE techsales_oltp;

INSERT INTO clientes
(nome, email, cidade, estado, data_cadastro, status)
VALUES
('  Ana Costa  ', 'ana.costa@email.com', 'Sao Paulo', 'sp', '2025-06-20', 'ATIVO'),
('Bruno Martins', 'bruno.martins@email.com ', ' santo andre ', 'SP', '2025-06-21', 'ATIVO'),
(' CARLA OLIVEIRA ', 'carla.oliveira@email.com', 'Maua', 'SP', '2025-06-22', 'ATIVO'),
('Diego Santos', 'diego.santos@email.com', 'São Paulo', 'SP', '2025-06-23', 'INATIVO');


UPDATE clientes
SET cidade = 'Santos'
WHERE id_cliente = 1;

UPDATE clientes
SET status = 'INATIVO'
WHERE id_cliente = 2;

UPDATE clientes
SET nome = '  Ricardo Santos  ',
    cidade = 'Campinas'
WHERE id_cliente = 3;


INSERT INTO produtos
(nome_produto, categoria, marca, preco, status_produto)
VALUES
('  SSD NVME 1TB  ', 'armazenamento', 'Kingston', 459.90, 'ATIVO'),
('Mouse Gamer RGB', ' PERIFERICO ', 'Logitech', 189.90, 'ATIVO'),
('Memoria RAM 16GB', 'memoria', 'Corsair', 329.90, 'ATIVO'),
('Monitor Gamer 27', ' MONITOR ', 'AOC', 1299.90, 'ATIVO');


UPDATE produtos
SET preco = 2799.90
WHERE id_produto = 1;


INSERT INTO vendedores
(nome, cargo, cidade, estado)
VALUES
('  Fernanda Lima ', 'Vendedor', 'São Paulo', 'SP'),
('GUSTAVO ALMEIDA', ' vendedor ', 'Maua', 'sp');


UPDATE vendedores
SET cargo = 'Gerente de Vendas'
WHERE id_vendedor = 1;


INSERT INTO lojas
(nome_loja, cidade, estado, tipo_loja)
VALUES
(' Tech Store ABC ', 'São Paulo', 'SP', 'FISICA'),
('Tech Store Maua', 'Maua', 'sp', 'OUTLET');


SET @id_cliente_1 = (
    SELECT id_cliente
    FROM clientes
    WHERE email = 'ana.costa@email.com'
    LIMIT 1
);

SET @id_cliente_2 = (
    SELECT id_cliente
    FROM clientes
    WHERE email = 'bruno.martins@email.com '
    LIMIT 1
);

SET @id_cliente_3 = (
    SELECT id_cliente
    FROM clientes
    WHERE email = 'carla.oliveira@email.com'
    LIMIT 1
);

SET @id_cliente_4 = (
    SELECT id_cliente
    FROM clientes
    WHERE email = 'diego.santos@email.com'
    LIMIT 1
);


SET @id_produto_1 = (
    SELECT id_produto
    FROM produtos
    WHERE nome_produto = '  SSD NVME 1TB  '
    LIMIT 1
);

SET @id_produto_2 = (
    SELECT id_produto
    FROM produtos
    WHERE nome_produto = 'Mouse Gamer RGB'
    LIMIT 1
);

SET @id_produto_3 = (
    SELECT id_produto
    FROM produtos
    WHERE nome_produto = 'Memoria RAM 16GB'
    LIMIT 1
);

SET @id_produto_4 = (
    SELECT id_produto
    FROM produtos
    WHERE nome_produto = 'Monitor Gamer 27'
    LIMIT 1
);


SET @id_loja_1 = (
    SELECT id_loja
    FROM lojas
    WHERE nome_loja = ' Tech Store ABC '
    LIMIT 1
);

SET @id_loja_2 = (
    SELECT id_loja
    FROM lojas
    WHERE nome_loja = 'Tech Store Maua'
    LIMIT 1
);


INSERT INTO vendas
(id_cliente, id_vendedor, id_loja, data_venda, forma_pagamento, status_venda)
VALUES
(@id_cliente_1, 1, @id_loja_1, '2025-06-20', 'PIX', 'FINALIZADA'),
(@id_cliente_2, 2, @id_loja_2, '2025-06-21', 'CRÉDITO', 'ENTREGUE'),
(@id_cliente_3, 1, @id_loja_1, '2025-06-22', 'DÉBITO', 'FINALIZADA'),
(@id_cliente_4, 2, @id_loja_2, '2025-06-23', 'BOLETO', 'PENDENTE');


SET @id_venda_1 = (
    SELECT id_venda
    FROM vendas
    WHERE id_cliente = @id_cliente_1
      AND data_venda = '2025-06-20'
    ORDER BY id_venda DESC
    LIMIT 1
);

SET @id_venda_2 = (
    SELECT id_venda
    FROM vendas
    WHERE id_cliente = @id_cliente_2
      AND data_venda = '2025-06-21'
    ORDER BY id_venda DESC
    LIMIT 1
);

SET @id_venda_3 = (
    SELECT id_venda
    FROM vendas
    WHERE id_cliente = @id_cliente_3
      AND data_venda = '2025-06-22'
    ORDER BY id_venda DESC
    LIMIT 1
);

SET @id_venda_4 = (
    SELECT id_venda
    FROM vendas
    WHERE id_cliente = @id_cliente_4
      AND data_venda = '2025-06-23'
    ORDER BY id_venda DESC
    LIMIT 1
);


INSERT INTO itens_venda
(id_venda, id_produto, quantidade, preco_unitario)
VALUES
(@id_venda_1, 1, 1, 2799.90),
(@id_venda_1, @id_produto_1, 2, 459.90),
(@id_venda_2, @id_produto_2, 1, 189.90),
(@id_venda_3, @id_produto_3, 2, 329.90),
(@id_venda_4, @id_produto_4, 1, 1299.90);


USE techsales_dw;

SET SQL_SAFE_UPDATES = 0;

CALL prc_pipeline();

SET SQL_SAFE_UPDATES = 1;


SELECT *
FROM dim_cliente
ORDER BY id_cliente_origem, sk_cliente;


SELECT *
FROM dim_produto
ORDER BY id_produto_origem, sk_produto;


SELECT *
FROM dim_vendedor
ORDER BY id_vendedor_origem, sk_vendedor;


SELECT *
FROM dim_loja
ORDER BY id_loja_origem, sk_loja;


SELECT *
FROM dim_tempo
ORDER BY data;


SELECT *
FROM fato_vendas
ORDER BY sk_venda;


CALL prc_carga_dim_tempo();


SELECT
    data,
    COUNT(*) AS quantidade
FROM dim_tempo
GROUP BY data
HAVING COUNT(*) > 1;


SELECT
    id_item_venda_origem,
    COUNT(*) AS quantidade
FROM fato_vendas
GROUP BY id_item_venda_origem
HAVING COUNT(*) > 1;


SET SQL_SAFE_UPDATES = 0;

CALL prc_pipeline();

SET SQL_SAFE_UPDATES = 1;


SELECT
    COUNT(*) AS total_registros
FROM fato_vendas;


SELECT
    COUNT(*) AS quantidade_itens,
    SUM(quantidade) AS quantidade_produtos,
    SUM(valor_total) AS faturamento_total
FROM fato_vendas;

SELECT * FROM techsales_dw.fato_vendas;