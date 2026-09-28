USE techsales_oltp;

-- INSERINDO OS DADOS;

INSERT INTO clientes
(nome, email, cidade, estado, data_cadastro, status)
VALUES
('João Silva', 'joao.silva@email.com', 'São Paulo', 'SP', '2025-01-15', 'ATIVO'),
(' maria santos ', 'maria.santos@email.com', 'Santo André', 'SP', '2025-02-20', 'ATIVO'),
('PEDRO OLIVEIRA', 'pedro.oliveira@email.com', 'Campinas', 'SP', '2025-03-10', 'ATIVO'),
('Ana Costa', 'ana.costa@email.com', 'Maua', 'SP', '2025-03-25', 'ATIVO'),
('carlos souza', 'carlos.souza@email.com', 'MAUÁ', 'SP', '2025-04-02', 'INATIVO'),
('Fernanda Lima', 'fernanda.lima@email.com', 'santo andre', 'SP', '2025-04-18', 'ATIVO'),
('  Ricardo Alves', 'ricardo.alves@email.com', 'São Paulo ', 'sp', '2025-05-05', 'ATIVO'),
('Juliana Martins', 'juliana.martins@email.com', ' Campinas ', 'SP', '2025-05-22', 'ATIVO'),
('ROBERTO DIAS', 'roberto.dias@email.com', 'São Paulo', 'SP', '2025-06-01', 'INATIVO'),
('Patricia Gomes', 'patricia.gomes@email.com', 'Mauá', 'SP', '2025-06-15', 'ATIVO');


INSERT INTO produtos
(nome_produto, categoria, marca, preco, status_produto)
VALUES
('Notebook Inspiron 15', 'Notebook', 'Dell', 3599.90, 'ATIVO'),
('Notebook IdeaPad 3', 'notebook', 'Lenovo', 2899.90, 'ATIVO'),
('Mouse Sem Fio M170', 'Periferico', 'Logitech', 89.90, 'ATIVO'),
('Teclado Mecânico K500', 'periférico', 'Redragon', 249.90, 'ATIVO'),
('Monitor 24 Polegadas', 'MONITOR', 'Samsung', 899.90, 'ATIVO'),
('Monitor Gamer 27', 'monitor', 'AOC', 1499.90, 'ATIVO'),
('SSD 1TB NVMe', 'Armazenamento', 'Kingston', 429.90, 'ATIVO'),
('SSD 480GB SATA', 'armazenamento', 'Kingston', 289.90, 'ATIVO'),
('Memória RAM 16GB', 'Memoria', 'Corsair', 349.90, 'ATIVO'),
('memória RAM 8GB', 'memória', 'Kingston', 189.90, 'INATIVO');


INSERT INTO vendedores
(nome, cargo, cidade, estado)
VALUES
('Lucas Ferreira', 'Vendedor', 'São Paulo', 'SP'),
('Amanda Rocha', 'Vendedora', 'Santo André', 'SP'),
('MARCOS OLIVEIRA', 'Vendedor', 'Mauá', 'SP'),
(' juliana souza ', 'Vendedora', 'Campinas', 'SP'),
('Rafael Lima', 'Supervisor', 'São Paulo', 'SP');


INSERT INTO lojas
(nome_loja, cidade, estado, tipo_loja)
VALUES
('Tech Store Paulista', 'São Paulo', 'SP', 'FISICA'),
('tech store ABC', 'Santo André', 'SP', 'FISICA'),
('Tech Online', 'São Paulo', 'SP', 'ONLINE'),
('Outlet Tech', 'Mauá', 'SP', 'OUTLET'),
('Tech Quiosque Campinas', 'Campinas', 'SP', 'QUIOSQUE');


INSERT INTO vendas
(id_cliente, id_vendedor, id_loja, data_venda, forma_pagamento, status_venda)
VALUES
(1, 1, 1, '2025-06-10', 'PIX', 'FINALIZADA'),
(2, 2, 2, '2025-06-11', 'CRÉDITO', 'ENTREGUE'),
(3, 3, 3, '2025-06-12', 'DÉBITO', 'FINALIZADA'),
(4, 1, 4, '2025-06-13', 'PIX', 'PENDENTE'),
(5, 4, 5, '2025-06-14', 'BOLETO', 'ENTREGUE'),
(6, 2, 1, '2025-06-15', 'CRÉDITO', 'FINALIZADA'),
(7, 5, 2, '2025-06-16', 'PIX', 'ENTREGUE'),
(8, 3, 3, '2025-06-17', 'DÉBITO', 'FINALIZADA'),
(9, 1, 4, '2025-06-18', 'CRÉDITO', 'PENDENTE'),
(10, 4, 5, '2025-06-19', 'PIX', 'ENTREGUE');


INSERT INTO itens_venda
(id_venda, id_produto, quantidade, preco_unitario)
VALUES
(1, 1, 1, 3599.90),
(1, 3, 2, 89.90),

(2, 2, 1, 2899.90),
(2, 4, 1, 249.90),

(3, 5, 2, 899.90),

(4, 7, 1, 429.90),
(4, 9, 2, 349.90),

(5, 6, 1, 1499.90),
(5, 3, 1, 89.90),

(6, 8, 1, 289.90),
(6, 10, 2, 189.90),

(7, 1, 1, 3599.90),
(7, 4, 1, 249.90),

(8, 5, 1, 899.90),
(8, 7, 1, 429.90),

(9, 2, 1, 2899.90),
(9, 3, 1, 89.90),

(10, 6, 2, 1499.90),
(10, 9, 1, 349.90);


SET SQL_SAFE_UPDATES = 0;

UPDATE techsales_dw.dim_cliente
SET data_inicio = '2025-06-10'
WHERE registro_atual = 1;

UPDATE techsales_dw.dim_produto
SET data_inicio = '2025-06-10'
WHERE registro_atual = 1;

UPDATE techsales_dw.dim_vendedor
SET data_inicio = '2025-06-10'
WHERE registro_atual = 1;

UPDATE techsales_dw.dim_loja
SET data_inicio = '2025-06-10'
WHERE registro_atual = 1;

SET SQL_SAFE_UPDATES = 1;



