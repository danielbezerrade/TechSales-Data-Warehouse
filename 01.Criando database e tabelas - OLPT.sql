-- Criação da Database , criando o BANCO DE DADOS TRANSACIONAL OLTP (PROCESSAMENTO DE TRANSAÇÃO ONLINE)

-- Criando DATABASE techsales_oltp
CREATE DATABASE techsales_oltp

	DEFAULT CHARACTER SET utf8mb4
    DEFAULT COLLATE utf8mb4_general_ci;
    
-- Selecionando o banco de dados criado - techsales_oltp
USE techsales_oltp;


-- Criando a tabela 'clientes'
CREATE TABLE clientes (
id_cliente INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(255) NOT NULL,
email VARCHAR(255) NOT NULL,
cidade VARCHAR(50) NOT NULL,
estado VARCHAR(25) NOT NULL,
data_cadastro DATE,
status ENUM('ATIVO','INATIVO') NOT NULL DEFAULT 'INATIVO');


-- Criando a tabela produtos
CREATE TABLE produtos(
id_produto INT AUTO_INCREMENT PRIMARY KEY,
nome_produto VARCHAR(255) NOT NULL,
categoria VARCHAR(50) NOT NULL,
marca VARCHAR(50) NOT NULL,
preco DECIMAL(10,2) NOT NULL,
status_produto ENUM('ATIVO','INATIVO') NOT NULL DEFAULT 'ATIVO');


-- Criando a tabela vendedores
CREATE TABLE vendedores(
id_vendedor INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(255) NOT NULL,
cargo VARCHAR(50) NOT NULL,
cidade VARCHAR(50) NOT NULL,
estado VARCHAR(25) NOT NULL);


-- criando a tabela lojas
CREATE TABLE lojas(
id_loja INT AUTO_INCREMENT PRIMARY KEY,
nome_loja VARCHAR(255) NOT NULL,
cidade VARCHAR(50) NOT NULL,
estado VARCHAR(25) NOT NULL,
tipo_loja ENUM('ONLINE','FISICA','OUTLET','QUIOSQUE') NOT NULL);


-- Criando a tabela vendas
CREATE TABLE vendas(
id_venda INT AUTO_INCREMENT PRIMARY KEY,
id_cliente INT ,
id_vendedor INT ,
id_loja INT ,
data_venda DATE,
forma_pagamento ENUM('PIX','CRÉDITO','DÉBITO','BOLETO') NOT NULL,
status_venda ENUM('FINALIZADA','PENDENTE','ENTREGUE') NOT NULL,

FOREIGN KEY(id_cliente) REFERENCES clientes(id_cliente),

FOREIGN KEY(id_vendedor) REFERENCES vendedores(id_vendedor),

FOREIGN KEY(id_loja) REFERENCES lojas(id_loja));

-- Criando a tabela itens venda
CREATE TABLE itens_venda(
id_item INT AUTO_INCREMENT PRIMARY KEY,
id_venda INT,
id_produto INT,
quantidade INT NOT NULL,
preco_unitario DECIMAL(10,2) NOT NULL,
FOREIGN KEY(id_venda) REFERENCES vendas(id_venda),
FOREIGN KEY(id_produto) REFERENCES produtos(id_produto));











