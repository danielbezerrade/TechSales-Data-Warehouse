## TRATAMENTO DE DADOS PARA A CARGA 

-- TRATAMENTO DE DADOS E CARGA 

-- Carga dim_clientes
SELECT * FROM techsales_oltp.clientes;
DROP PROCEDURE IF EXISTS prc_carga_dim_cliente;

DELIMITER //

CREATE PROCEDURE prc_carga_dim_cliente()
BEGIN 

    
    INSERT INTO techsales_dw.dim_cliente(
        id_cliente_origem,
        nome,
        email,
        cidade,
        estado,
        data_cadastro,
        status,
        data_inicio,
        data_fim,
        registro_atual
    )
    SELECT 
        o.id_cliente,
        TRIM(UPPER(o.nome)),
        TRIM(o.email),
        TRIM(UPPER(o.cidade)),
        TRIM(o.estado),
        o.data_cadastro,
        o.status,
        CURDATE(),
        NULL,
        1
    FROM techsales_oltp.clientes o
    LEFT JOIN techsales_dw.dim_cliente c
        ON o.id_cliente = c.id_cliente_origem
    WHERE c.id_cliente_origem IS NULL;


   
    UPDATE techsales_dw.dim_cliente AS d 
    JOIN techsales_oltp.clientes o
        ON d.id_cliente_origem = o.id_cliente
    SET 
        d.data_fim = CURDATE(),
        d.registro_atual = 0
    WHERE d.registro_atual = 1 
      AND (
          d.nome <> TRIM(UPPER(o.nome))
          OR d.email <> TRIM(o.email)
          OR d.cidade <> TRIM(UPPER(o.cidade))
          OR d.estado <> TRIM(UPPER(o.estado))
          OR d.data_cadastro <> o.data_cadastro
          OR d.status <> o.status
      );


    
    INSERT INTO techsales_dw.dim_cliente(
        id_cliente_origem,
        nome,
        email,
        cidade,
        estado,
        data_cadastro,
        status,
        data_inicio,
        data_fim,
        registro_atual
    )
    SELECT 
        o.id_cliente,
        TRIM(UPPER(o.nome)),
        TRIM(o.email),
        TRIM(UPPER(o.cidade)),
        TRIM(o.estado),
        o.data_cadastro,
        o.status,
        CURDATE(),
        NULL,
        1
    FROM techsales_oltp.clientes o
    JOIN techsales_dw.dim_cliente c
        ON o.id_cliente = c.id_cliente_origem
    WHERE c.registro_atual = 0 
      AND c.data_fim = CURDATE();

END//

DELIMITER ;



SET  SQL_SAFE_UPDATES = 0;

CALL prc_carga_dim_cliente();

SET SQL_SAFE_UPDATES = 1;

SELECT * FROM techsales_dw.dim_cliente;


-- Carga dim produtos

SELECT * FROM techsales_oltp.produtos;

DROP PROCEDURE IF EXISTS prc_carga_dim_produto;

DELIMITER //

CREATE PROCEDURE prc_carga_dim_produto()
BEGIN 
INSERT INTO techsales_dw.dim_produto(
	id_produto_origem,
    nome_produto,categoria,marca,preco,status_produto,
    data_inicio,data_fim,registro_atual)
    SELECT p.id_produto,TRIM(UCASE(p.nome_produto)),
    CASE 
    WHEN TRIM(UPPER(p.categoria)) IN ('PERIFERICO','PERIFÉRICO') THEN 'PERIFÉRICO' 
    WHEN TRIM(UPPER(p.categoria)) IN ('MEMORIA','MEMÓRIA') THEN 'MEMÓRIA'
    ELSE TRIM(UPPER(p.categoria))
    END, 
    TRIM(UPPER(p.marca)),p.preco,TRIM(UCASE(p.status_produto)),CURDATE(),NULL,1
    FROM techsales_oltp.produtos p 
    LEFT JOIN techsales_dw.dim_produto d 
    ON p.id_produto = d.id_produto_origem
    WHERE d.id_produto_origem IS NULL;
    
    UPDATE techsales_dw.dim_produto p 
    JOIN techsales_oltp.produtos pr
    ON p.id_produto_origem = pr.id_produto
    SET p.data_fim = CURDATE(), p.registro_atual = 0
    WHERE p.registro_atual = 1 
    AND (p.nome_produto <> TRIM(UPPER(pr.nome_produto)) OR 
		p.categoria <> CASE 
    WHEN TRIM(UPPER(pr.categoria)) IN ('PERIFERICO','PERIFÉRICO') THEN 'PERIFÉRICO' 
    WHEN TRIM(UPPER(pr.categoria)) IN ('MEMORIA','MEMÓRIA') THEN 'MEMÓRIA'
    ELSE TRIM(UPPER(pr.categoria))
    END OR p.marca <> TRIM(UPPER(pr.marca)) OR p.preco <> pr.preco OR p.status_produto <> pr.status_produto); 
    
    INSERT INTO techsales_dw.dim_produto(
	id_produto_origem,
    nome_produto,categoria,marca,preco,status_produto,
    data_inicio,data_fim,registro_atual)
    SELECT p.id_produto,TRIM(UPPER(p.nome_produto)),
    CASE 
    WHEN TRIM(UPPER(p.categoria)) IN ('PERIFERICO','PERIFÉRICO') THEN 'PERIFÉRICO' 
    WHEN TRIM(UPPER(p.categoria)) IN ('MEMORIA','MEMÓRIA') THEN 'MEMÓRIA'
    ELSE TRIM(UPPER(p.categoria))
    END, 
    TRIM(UPPER(p.marca)),p.preco,TRIM(UCASE(p.status_produto)),CURDATE(),NULL,1
    FROM techsales_oltp.produtos p 
    JOIN techsales_dw.dim_produto d 
    ON p.id_produto = d.id_produto_origem
    WHERE d.registro_atual = 0
    AND d.data_fim = CURDATE();
    END//
    
    DELIMITER ;
    
SET SQL_SAFE_UPDATES = 0;

CALL prc_carga_dim_produto();

SET SQL_SAFE_UPDATES = 1;

SELECT * FROM techsales_dw.dim_produto;


-- CARGA dim_vendedor

DROP PROCEDURE IF EXISTS prc_carga_dim_vendedor;

DELIMITER //

CREATE PROCEDURE prc_carga_dim_vendedor()
BEGIN 

INSERT INTO techsales_dw.dim_vendedor(
    id_vendedor_origem,
    nome,
    cargo,
    cidade,
    estado,
    data_inicio,
    data_fim,
    registro_atual)
    SELECT 
        v.id_vendedor,
        TRIM(UPPER(v.nome)),
        TRIM(UPPER(v.cargo)),
        TRIM(UPPER(v.cidade)),
        TRIM(UPPER(v.estado)),
        CURDATE(),
        NULL,
        1
    FROM techsales_oltp.vendedores v
    LEFT JOIN techsales_dw.dim_vendedor d
        ON v.id_vendedor = d.id_vendedor_origem
    WHERE d.id_vendedor_origem IS NULL;


    UPDATE techsales_dw.dim_vendedor v
    JOIN techsales_oltp.vendedores ve
        ON v.id_vendedor_origem = ve.id_vendedor
    SET 
        v.data_fim = CURDATE(),
        v.registro_atual = 0
    WHERE v.registro_atual = 1 
    AND (
        v.nome <> TRIM(UPPER(ve.nome))
        OR v.cargo <> TRIM(UPPER(ve.cargo))
        OR v.cidade <> TRIM(UPPER(ve.cidade))
        OR v.estado <> TRIM(UPPER(ve.estado))
    );


    INSERT INTO techsales_dw.dim_vendedor(
        id_vendedor_origem,
        nome,
        cargo,
        cidade,
        estado,
        data_inicio,
        data_fim,
        registro_atual)
    SELECT 
        v.id_vendedor,
        TRIM(UPPER(v.nome)),
        TRIM(UPPER(v.cargo)),
        TRIM(UPPER(v.cidade)),
        TRIM(UPPER(v.estado)),
        CURDATE(),
        NULL,
        1
    FROM techsales_oltp.vendedores v
    JOIN techsales_dw.dim_vendedor d
        ON v.id_vendedor = d.id_vendedor_origem
    WHERE d.registro_atual = 0
    AND d.data_fim = CURDATE();

END//

DELIMITER ;

SET SQL_SAFE_UPDATES = 0;

CALL prc_carga_dim_vendedor();

SET SQL_SAFE_UPDATES = 1;

SELECT * FROM techsales_dw.dim_vendedor;


-- CARGA dim_loja

DROP PROCEDURE IF EXISTS prc_carga_dim_tempo;

DELIMITER //

CREATE PROCEDURE prc_carga_dim_tempo()
BEGIN 

    INSERT INTO techsales_dw.dim_tempo(
        data,
        dia,
        mes,
        ano
    )
    SELECT DISTINCT
        v.data_venda,
        DAY(v.data_venda),
        MONTH(v.data_venda),
        YEAR(v.data_venda)
    FROM techsales_oltp.vendas v
    LEFT JOIN techsales_dw.dim_tempo t
        ON v.data_venda = t.data
    WHERE t.data IS NULL;

END//

DELIMITER ;

CALL prc_carga_dim_tempo();

SELECT * FROM techsales_dw.dim_tempo;


-- Carga fato vendas


DROP PROCEDURE IF EXISTS prc_carga_fato_vendas;

DELIMITER //

CREATE PROCEDURE prc_carga_fato_vendas()
BEGIN 

    INSERT INTO techsales_dw.fato_vendas(
        id_item_venda_origem,
        id_venda_origem,
        sk_cliente,
        sk_produto,
        sk_vendedor,
        sk_loja,
        sk_tempo,
        quantidade,
        preco_unitario,
        valor_total,
        forma_pagamento,
        status_venda
    )
    SELECT
        i.id_item,
        v.id_venda,

        c.sk_cliente,
        p.sk_produto,
        ve.sk_vendedor,
        l.sk_loja,
        t.sk_tempo,

        i.quantidade,
        i.preco_unitario,
        i.quantidade * i.preco_unitario,

        v.forma_pagamento,
        v.status_venda

    FROM techsales_oltp.vendas v

    JOIN techsales_oltp.itens_venda i
        ON v.id_venda = i.id_venda

    JOIN techsales_dw.dim_cliente c
        ON v.id_cliente = c.id_cliente_origem
        AND v.data_venda >= c.data_inicio
        AND (v.data_venda <= c.data_fim OR c.data_fim IS NULL)

    JOIN techsales_dw.dim_produto p
        ON i.id_produto = p.id_produto_origem
        AND v.data_venda >= p.data_inicio
        AND (v.data_venda <= p.data_fim OR p.data_fim IS NULL)

    JOIN techsales_dw.dim_vendedor ve
        ON v.id_vendedor = ve.id_vendedor_origem
        AND v.data_venda >= ve.data_inicio
        AND (v.data_venda <= ve.data_fim OR ve.data_fim IS NULL)

    JOIN techsales_dw.dim_loja l
        ON v.id_loja = l.id_loja_origem
        AND v.data_venda >= l.data_inicio
        AND (v.data_venda <= l.data_fim OR l.data_fim IS NULL)

    JOIN techsales_dw.dim_tempo t
        ON v.data_venda = t.data

    LEFT JOIN techsales_dw.fato_vendas f
        ON i.id_item = f.id_item_venda_origem

    WHERE f.id_item_venda_origem IS NULL;

END//

DELIMITER ;
    
SET SQL_SAFE_UPDATES = 0;

CALL prc_carga_fato_vendas();

SET SQL_SAFE_UPDATES = 1;

SELECT * FROM techsales_dw.fato_vendas;
    
        
	
    
    
    
    

