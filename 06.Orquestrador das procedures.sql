-- ORQUESTRADOR DO PIPELINE 

DROP PROCEDURE IF EXISTS prc_pipeline;

DELIMITER //

CREATE PROCEDURE prc_pipeline()
BEGIN 
CALL prc_carga_dim_cliente();
CALL prc_carga_dim_produto();
CALL prc_carga_dim_vendedor();
CALL prc_carga_dim_loja();
CALL prc_carga_dim_tempo();
CALL prc_carga_fato_vendas();
END//

DELIMITER ;

-- CHAMANDO O ORQUESTRADOR

SET SQL_SAFE_UPDATES = 0;

CALL prc_pipeline();

SET SQL_SAFE_UPDATES = 1;

SELECT * FROM techsales_dw.fato_vendas;