## Etapa de diagnóstico 

USE techsales_oltp;

SELECT VERSION();

## Verificando a quantidade de clientes por cidade

SELECT * FROM clientes;

SELECT cidade,COUNT(*) AS quantidade_clientes 
FROM clientes
GROUP BY cidade
ORDER BY quantidade_clientes DESC;

-- ANÁLISE EXPLORATÓRIA

SELECT * FROM clientes;

SELECT nome,TRIM(nome) AS nome 
FROM clientes;

SELECT nome,TRIM(UCASE(nome)) AS nome_maiusculo
FROM clientes;

SELECT cidade,TRIM(UPPER(cidade)) AS cidade_tratado
FROM clientes;

SELECT cidade, REPLACE(TRIM(UPPER(cidade)),'MAUA','MAUÁ') AS cidade_ajustado
FROM clientes; 


SELECT cidade,REPLACE(UPPER(TRIM(cidade)),'SANTO ANDRE','SANTO ANDRÉ') as cidade_ajustado
FROM clientes;

SELECT cidade,REPLACE(REPLACE(TRIM(UPPER(cidade)),'MAUA','MAUÁ'),'SANTO ANDRE','SANTO ANDRÉ') AS cidade_tratado
FROM clientes;

-- Analisando coluna estado

SELECT DISTINCT estado,TRIM(UPPER(estado)) AS estado_tratado
FROM clientes;

-- Analisando coluna e-mail

SELECT * FROM clientes;

SELECT email,TRIM(email) AS email_tratado 
FROM clientes;

-- Analisando a coluna data cadastro 

SELECT * FROM clientes;

SELECT COUNT(*) AS quantidade_clientes_sem_cadastro
FROM clientes
WHERE data_cadastro IS NULL;


-- verificando clientes null 

SELECT * FROM clientes;

SELECT id_cliente,nome,data_cadastro 
FROM clientes 
WHERE data_cadastro IS NULL;


### VERIFICANDO A TABELA PRODUTOS

SELECT * FROM produtos;

SELECT categoria,COUNT(*) AS quantidade_por_categoria
FROM produtos
GROUP BY categoria
ORDER BY quantidade_por_categoria DESC;

SELECT nome_produto,TRIM(nome_produto) AS nome_produto_ajustado
FROM produtos;

SELECT nome_produto,TRIM(UPPER(nome_produto)) AS nome_produto_ajustado
FROM produtos;

SELECT * FROM produtos; 

SELECT categoria,REPLACE(TRIM(UPPER(categoria)),'PERIFERICO','PERIFÉRICO') AS categoria_ajustado
FROM produtos;

SELECT categoria,REPLACE(REPLACE(TRIM(UPPER(categoria)),'PERIFERICO','PERIFÉRICO'),'MEMORIA','MEMÓRIA') AS categoria_ajustado
FROM produtos;

SELECT * FROM produtos;

SELECT marca,COUNT(*) AS quantidade_por_marca
FROM produtos
GROUP BY marca
ORDER BY quantidade_por_marca DESC;

SELECT marca,TRIM(UPPER(marca)) AS marca_tratado
FROM produtos;

SELECT ROUND(AVG(preco),2) AS preco_medio,MAX(preco) AS preco_maximo,MIN(preco) AS preco_minimo
FROM produtos;

SELECT id_produto,nome_produto,preco
FROM produtos
ORDER BY preco DESC;

-- VERIFICANDO SE EXISTEM VALORES NULOS

SELECT id_produto,nome_produto,preco
FROM produtos
WHERE preco <= 0;

SELECT id_produto,nome_produto,preco
FROM produtos
WHERE preco <= 0;


#### VERIFICANDO A TABELA itens_venda

SELECT * FROM itens_venda;

SELECT id_item,id_venda,id_produto,quantidade
FROM itens_venda
WHERE quantidade <= 0;

SELECT ROUND(AVG(preco_unitario),2) AS preco_medio,MAX(preco_unitario) AS maior_preco_unitario,MIN(preco_unitario) AS menor_preco_unitario
FROM itens_venda;


SELECT * FROM produtos;
SELECT * FROM itens_venda;

SELECT i.id_venda,p.id_produto,p.nome_produto,i.preco_unitario,p.preco
FROM produtos p
JOIN itens_venda i
ON p.id_produto = i.id_produto
WHERE i.preco_unitario != p.preco;


#### VERIFICANDO A TABELA vendas

SELECT * FROM vendas;

SELECT status_venda,COUNT(*) AS quantidade_por_status
FROM vendas
GROUP BY status_venda;

SELECT forma_pagamento,COUNT(*) AS quantidade_por_pagamento
FROM vendas 
GROUP BY forma_pagamento
ORDER BY quantidade_por_pagamento DESC;

SELECT id_venda,data_venda
FROM vendas
WHERE data_venda IS NULL;

SELECT * FROM vendas;

SELECT id_cliente,id_vendedor,id_loja
FROM vendas 
WHERE id_cliente IS NULL OR id_vendedor IS NULL OR id_loja IS NULL;

SELECT * FROM produtos;
SELECT * FROM itens_venda;

SELECT v.id_venda,p.id_produto,p.nome_produto
FROM itens_venda v 
LEFT JOIN produtos p
ON p.id_produto = v.id_produto
WHERE p.id_produto IS NULL;


SELECT * FROM vendas;
SELECT * FROM clientes;

SELECT c.id_cliente,v.id_venda,c.nome
FROM vendas v 
LEFT JOIN clientes c
ON v.id_cliente = c.id_cliente
WHERE c.id_cliente IS NULL;
 
 
### Tabela vendedores

SELECT * FROM vendedores;
SELECT * FROM vendas;

SELECT ve.id_vendedor
FROM vendas v 
LEFT JOIN vendedores ve
ON v.id_vendedor = ve.id_vendedor
WHERE ve.id_vendedor IS NULL;


##fazenodo verificação na tabelas lojas 

SELECT * FROM lojas;
SELECT * FROM vendas;

SELECT v.id_venda,v.id_loja,l.id_loja,l.nome_loja
FROM vendas v 
LEFT JOIN lojas l 
ON v.id_loja = l.id_loja
WHERE l.id_loja IS NULL; 


## validação de datas

SELECT MIN(data_venda) AS menor_data,MAX(data_venda) AS maior_data
FROM vendas;


SELECT id_venda,data_venda
FROM vendas 
WHERE data_venda > CURRENT_DATE();


## Existem clientes com data_cadastro posterior à data atual?

SELECT id_cliente,nome,data_cadastro
FROM clientes
WHERE data_cadastro > CURRENT_DATE();

## valores nulos em itens_venda 

SELECT * FROM produtos;
SELECT * FROM itens_venda;

SELECT id_item,id_venda,id_produto
FROM itens_venda
WHERE id_venda IS NULL OR id_produto IS NULL;


## consistência do valor total 

SELECT id_item,id_venda,id_produto,quantidade,preco_unitario, (quantidade * preco_unitario) AS valor_total
FROM itens_venda;

## total por venda

SELECT id_venda,SUM(quantidade * preco_unitario) AS valor_total FROM itens_venda
GROUP BY id_venda;



-- total de cada venda com informações da venda 

SELECT i.id_venda,v.data_venda,v.forma_pagamento,v.status_venda,SUM(i.quantidade * i.preco_unitario) AS valor_total
FROM itens_venda i 
JOIN vendas v 
ON i.id_venda = v.id_venda
GROUP BY i.id_venda,v.data_venda,v.forma_pagamento,v.status_venda;


## itens com preço unitário inválido. 

SELECT * FROM itens_venda;

SELECT id_item,id_venda,id_produto,preco_unitario
FROM itens_venda
WHERE preco_unitario <= 0;




