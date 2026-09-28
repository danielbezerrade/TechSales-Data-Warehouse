# TechSales Data Engineering Pipeline

Projeto de Engenharia de Dados utilizando **MySQL e SQL**, simulando um processo de ETL desde um banco de vendas até um Data Warehouse.

## Sobre o projeto

O projeto foi desenvolvido para praticar:

* SQL
* ETL
* Data Warehouse
* Modelagem dimensional
* SCD Tipo 2
* Carga incremental
* Stored Procedures

## Estrutura

```text id="r7x4ke"
OLTP
  ↓
Tratamento dos dados
  ↓
Data Warehouse
  ↓
Carga incremental
```

### Banco OLTP

Contém as tabelas:

* clientes
* produtos
* vendedores
* lojas
* vendas
* itens_venda

### Data Warehouse

Contém:

* dim_cliente
* dim_produto
* dim_vendedor
* dim_loja
* dim_tempo
* fato_vendas

## ETL

O tratamento dos dados foi realizado diretamente no SQL, utilizando funções como:

```sql id="9p8j3c"
TRIM()
UPPER()
REPLACE()
```

Também foram criadas **Stored Procedures** para realizar as cargas.

## SCD Tipo 2

Foi utilizado SCD Tipo 2 para manter o histórico de alterações nas dimensões.

```text id="3j9k2m"
data_inicio
data_fim
registro_atual
```

## Carga incremental

O projeto possui controle para:

* Inserir novos registros;
* Atualizar registros alterados;
* Manter histórico;
* Evitar registros duplicados.

## Resultado

Após os testes de carga:

* **19 registros na fato**
* **24 unidades vendidas**
* **R$ 23.637,60 em faturamento**

## Tecnologias

* MySQL
* SQL
* ETL
* Data Warehouse
* Stored Procedures
* SCD Tipo 2

## Autor

**Daniel Barros**

Projeto desenvolvido para estudos e portfólio em **Engenharia de Dados**.
