# ERP Database Project

## Descrição
Projeto de banco de dados relacional para gerenciamento de pedidos, clientes, produtos, fornecedores, funcionários e transportadoras.

## Estrutura do Banco
- **Customers:** Informações dos clientes
- **Orders:** Pedidos realizados
- **OrderDetails:** Detalhes dos itens do pedido
- **Products:** Catálogo de produtos
- **Categories:** Categorias de produtos
- **Suppliers:** Fornecedores
- **Employees:** Funcionários
- **Shippers:** Transportadoras

## Relacionamentos
- OrderDetails → Orders e Products
- Orders → Customers, Employees e Shippers
- Products → Suppliers e Categories
