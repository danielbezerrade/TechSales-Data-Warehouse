-- CRIANDO DATABASE DATA WAREHOUSE

CREATE DATABASE techsales_dw

	DEFAULT CHARACTER SET utf8mb4
    DEFAULT COLLATE utf8mb4_general_ci;
    
## CRIANDO AS DIMENSOES 

CREATE TABLE dim_cliente(
sk_cliente INT AUTO_INCREMENT PRIMARY KEY,
id_cliente_origem INT NOT NULL,
nome VARCHAR(255) NOT NULL,
email VARCHAR(255) NOT NULL,
cidade VARCHAR(25) NOT NULL,
estado VARCHAR(25) NOT NULL,
data_cadastro DATE NOT NULL,
status ENUM('ATIVO','INATIVO') NOT NULL DEFAULT 'INATIVO',
data_inicio DATE NOT NULL,
data_fim DATE,
registro_atual TINYINT(1) NOT NULL DEFAULT 1); -- TINYINT TIPO INTEIRO - TINYINT(1) é usado por convenção para representar 0/1 (booleano)


CREATE TABLE dim_produto (
sk_produto INT AUTO_INCREMENT PRIMARY KEY,
id_produto_origem INT NOT NULL,
nome_produto VARCHAR(255) NOT NULL,
categoria VARCHAR(255) NOT NULL,
marca VARCHAR(255) NOT NULL,
preco DECIMAL(10,2) NOT NULL,
data_inicio DATE NOT NULL,
data_fim DATE,
registro_atual TINYINT(1) NOT NULL DEFAULT 1,
status_produto ENUM('ATIVO','INATIVO') NOT NULL DEFAULT 'ATIVO');


CREATE TABLE dim_vendedor(
sk_vendedor INT AUTO_INCREMENT PRIMARY KEY,
id_vendedor_origem INT NOT NULL,
nome VARCHAR(255) NOT NULL,
cargo VARCHAR(255) NOT NULL,
cidade VARCHAR(25) NOT NULL,
estado VARCHAR(25) NOT NULL,
data_inicio DATE NOT NULL,
data_fim DATE,
registro_atual TINYINT(1) NOT NULL DEFAULT 1);

CREATE TABLE dim_loja(
sk_loja INT AUTO_INCREMENT PRIMARY KEY,
id_loja_origem INT NOT NULL,
nome_loja VARCHAR(255) NOT NULL,
cidade VARCHAR(25) NOT NULL,
estado VARCHAR(25) NOT NULL,
tipo_loja ENUM('ONLINE','FISICA','OUTLET','QUIOSQUE') NOT NULL,
data_inicio DATE NOT NULL,
data_fim DATE,
registro_atual TINYINT(1) NOT NULL DEFAULT 1);

CREATE TABLE dim_tempo(
sk_tempo INT AUTO_INCREMENT PRIMARY KEY,
data DATE NOT NULL,
dia INT NOT NULL,
mes INT NOT NULL,
ano INT NOT NULL);



CREATE TABLE fato_vendas(
    sk_venda INT AUTO_INCREMENT PRIMARY KEY,
    id_item_venda_origem INT NOT NULL,
    id_venda_origem INT NOT NULL,

    sk_cliente INT NOT NULL,
    sk_produto INT NOT NULL,
    sk_vendedor INT NOT NULL,
    sk_loja INT NOT NULL,
    sk_tempo INT NOT NULL,

    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL,

    forma_pagamento ENUM('PIX','CRÉDITO','DÉBITO','BOLETO') NOT NULL,
    status_venda ENUM('FINALIZADA','PENDENTE','ENTREGUE') NOT NULL,

    FOREIGN KEY (sk_cliente) REFERENCES dim_cliente(sk_cliente),
    FOREIGN KEY (sk_produto) REFERENCES dim_produto(sk_produto),
    FOREIGN KEY (sk_vendedor) REFERENCES dim_vendedor(sk_vendedor),
    FOREIGN KEY (sk_loja) REFERENCES dim_loja(sk_loja),
    FOREIGN KEY (sk_tempo) REFERENCES dim_tempo(sk_tempo)
);





    
