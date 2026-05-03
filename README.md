# Olist E-commerce Analytics

Projeto completo de análise de dados utilizando **Python, MySQL e Power BI** para analisar vendas, logística, clientes, avaliações e vendedores de um marketplace brasileiro de e-commerce.

---

## Objetivo do Projeto

O objetivo deste projeto foi simular um fluxo real de análise de dados, partindo de arquivos CSV brutos até a construção de um dashboard analítico no Power BI.

O projeto cobre as seguintes etapas:

- Limpeza e preparação dos dados com Python
- Criação de banco de dados no MySQL
- Validação de chaves e relacionamentos com SQL
- Modelagem dimensional para Power BI
- Criação de medidas DAX
- Desenvolvimento de dashboard interativo
- Geração de insights e recomendações de negócio

---

## Ferramentas Utilizadas

- Python
- Pandas
- MySQL
- SQL
- Power BI
- DAX
- GitHub

---

## Estrutura do Projeto

```text
olist-ecommerce-analytics/
│
├── data/
│   ├── raw/
│   └── processed/
│
├── notebooks/
│   ├── 01_data_understanding.ipynb
│   ├── 02_data_cleaning.ipynb
│   └── 03_load_to_mysql.ipynb
│
├── sql/
│   ├── 01_create_database_and_tables.sql
│   ├── 02_validation_queries.sql
│   ├── 03_create_views.sql
│   └── 04_powerbi_views.sql
│
├── powerbi/
│   └── > The Power BI file is available upon request due to GitHub file size limitations.
│
├── images/
│   ├── executive_overview.png
│   ├── sales_products.png
│   ├── logistics.png
│   ├── customers_reviews.png
│   ├── sellers.png
│   └── final_insights.png
│
└── README.md


Etapas do Projeto
1. Preparação dos Dados com Python

A primeira etapa foi realizada em Python com a biblioteca Pandas.

Foram feitas análises iniciais das tabelas, verificação de valores nulos, duplicidades, tipos de dados e criação de novas colunas analíticas.

Algumas colunas criadas:

delivery_time_days
delivery_delay_days
delivery_status
is_late
item_total_value
product_volume_cm3
has_review_comment
2. Carga e Modelagem no MySQL

Após a limpeza, os dados foram carregados no MySQL.

Foram criadas tabelas staging e views analíticas para organizar o modelo de dados antes da conexão com o Power BI.

Também foram feitas validações de:

Chaves primárias
Chaves compostas
Relacionamentos entre tabelas
Quantidade de registros
Consistência entre receita de itens e pagamentos
3. Modelagem para Power BI

A camada final para o Power BI foi estruturada com tabelas de dimensão e fato:

dim_customers
dim_sellers
dim_products
fact_orders
fact_order_items
fact_payments_by_order
fact_reviews_by_order

Essa estrutura permitiu criar um modelo mais organizado, evitando duplicidades e facilitando a criação das medidas DAX.

## Dashboard Power BI

O dashboard foi dividido em seis páginas principais.

---

### Executive Overview

Visão geral de receita, pedidos, ticket médio, itens entregues, avaliação média, prazo médio, taxa de atraso e taxa de entrega.

![Executive Overview](https://github.com/ppossidio/olist-ecommerce-analytics/blob/1ccb3098af0aebf4583ceea256b29ac5b487e317/images/executive_overview.png) 

---

### Sales & Products

Análise de receita por categoria, produtos mais vendidos, preço médio, frete médio e participação do frete por categoria.

![Sales & Products](https://github.com/ppossidio/olist-ecommerce-analytics/blob/1ccb3098af0aebf4583ceea256b29ac5b487e317/images/sales_products.png)

---

### Logistics

Análise de performance logística, incluindo prazo médio de entrega, pedidos atrasados, taxa de atraso por categoria e impacto da entrega na avaliação dos clientes.

![Logistics](https://github.com/ppossidio/olist-ecommerce-analytics/blob/1ccb3098af0aebf4583ceea256b29ac5b487e317/images/logistics.png)

---

### Customers & Reviews

Análise de clientes únicos, clientes recorrentes, distribuição das avaliações, taxa de comentários e satisfação por status de entrega.

![Customers & Reviews](https://github.com/ppossidio/olist-ecommerce-analytics/blob/1ccb3098af0aebf4583ceea256b29ac5b487e317/images/customers_reviews.png)

---

### Sellers

Análise de performance dos vendedores, concentração de receita, receita por estado do vendedor, taxa de atraso por seller e prazo médio de entrega por estado.

![Sellers](https://raw.githubusercontent.com/ppossidio/olist-ecommerce-analytics/refs/heads/main/images/sellers.png)

---

### Final Insights

Página final com principais achados, riscos de negócio e recomendações estratégicas.

![Final Insights](https://github.com/ppossidio/olist-ecommerce-analytics/blob/1ccb3098af0aebf4583ceea256b29ac5b487e317/images/final_insights.png)

---

Principais Insights

Alguns dos principais insights encontrados:

A receita está concentrada em poucas categorias e estados de vendedores.
As categorias Health & Beauty, Watches & Gifts e Bed/Bath/Table são os principais motores de receita.
A performance logística tem forte impacto na satisfação dos clientes.
Pedidos atrasados ou não entregues possuem notas médias significativamente menores.
Clientes insatisfeitos tendem a deixar comentários com mais frequência.
Alguns vendedores com alta receita também apresentam variação relevante na taxa de atraso.
O peso do frete varia bastante por categoria e deve ser monitorado na estratégia comercial.
Recomendações de Negócio

Com base na análise, as principais recomendações são:

Priorizar melhorias logísticas em categorias e estados com maior taxa de atraso.
Monitorar vendedores de alta receita que também apresentam maior taxa de atraso.
Fortalecer categorias com alta receita e boa satisfação dos clientes.
Investigar comentários negativos para identificar problemas recorrentes.
Usar a participação do frete por categoria para apoiar decisões de preço e estratégia logística.
Competências Demonstradas

Este projeto demonstra conhecimentos em:

Limpeza de dados com Python
Manipulação de dados com Pandas
Banco de dados MySQL
Consultas SQL
Modelagem dimensional
Power BI
DAX
Criação de dashboards
Storytelling com dados
Geração de insights de negócio
Status do Projeto

Projeto concluído.

Possíveis melhorias futuras:

Análise de cohort de clientes
Segmentação de vendedores
Previsão de atrasos
Análise de sentimento dos comentários
Publicação do dashboard no Power BI Service
