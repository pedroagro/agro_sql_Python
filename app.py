import streamlit as st
import pandas as pd
import plotly.express as px
from datetime import datetime

# ----------------------------
# CONFIGURAÇÕES INICIAIS
# ----------------------------
st.set_page_config(page_title="Dashboard de Vendas (Offline)", layout="wide")
st.title("📊 Dashboard de Vendas com Arquivos CSV")

# ----------------------------
# CARREGAR DADOS DOS ARQUIVOS CSV
# ----------------------------
clientes = pd.read_csv("clientes.csv")
produtos = pd.read_csv("produtos.csv")
pedidos = pd.read_csv("pedidos.csv")
itens_pedido = pd.read_csv("itens_pedido.csv")

# Converter colunas de data
pedidos['data_pedido'] = pd.to_datetime(pedidos['data_pedido'])
clientes['data_cadastro'] = pd.to_datetime(clientes['data_cadastro'])

# Juntar dados simulando a query SQL
dados = pedidos.merge(clientes, on='id_cliente')
dados = dados.merge(itens_pedido, on='id_pedido')
dados = dados.merge(produtos, on='id_produto')
dados['total_item'] = dados['quantidade'] * dados['preco_unitario']

# Renomear colunas para evitar conflitos
if 'nome_x' in dados.columns and 'nome_y' in dados.columns:
    dados = dados.rename(columns={'nome_x': 'cliente', 'nome_y': 'produto'})

# ----------------------------
# FILTROS
# ----------------------------
st.sidebar.header("🔎 Filtros")
data_inicio = st.sidebar.date_input("Data inicial", value=dados['data_pedido'].min())
data_fim = st.sidebar.date_input("Data final", value=dados['data_pedido'].max())
nome_cliente = st.sidebar.text_input("Filtrar por nome do cliente")

# Aplicar filtros
dados_filtrados = dados[(dados['data_pedido'] >= pd.to_datetime(data_inicio)) &
                        (dados['data_pedido'] <= pd.to_datetime(data_fim))]
if nome_cliente:
    dados_filtrados = dados_filtrados[dados_filtrados['cliente'].str.contains(nome_cliente, case=False)]

# ----------------------------
# TABELA DE PEDIDOS
# ----------------------------
st.subheader("📄 Tabela de Pedidos")
st.dataframe(dados_filtrados)

# ----------------------------
# GRÁFICO DE VENDAS MENSAIS
# ----------------------------
dados_filtrados['mes_ano'] = dados_filtrados['data_pedido'].dt.to_period('M').astype(str)
vendas_mensais = dados_filtrados.groupby('mes_ano')['valor_total'].sum().reset_index()

st.subheader("📈 Tendência de Vendas por Mês")
fig = px.line(vendas_mensais, x='mes_ano', y='valor_total', markers=True, title='Receita Mensal')
st.plotly_chart(fig, use_container_width=True)

# ----------------------------
# GRÁFICO DE TOP CLIENTES
# ----------------------------
top_clientes = dados_filtrados.groupby('cliente')['valor_total'].sum().reset_index()
top_clientes = top_clientes.sort_values(by='valor_total', ascending=False).head(10)

st.subheader("🏅 Top 10 Clientes por Faturamento")
fig2 = px.bar(top_clientes, x='cliente', y='valor_total', title='Top Clientes')
st.plotly_chart(fig2, use_container_width=True)

# ----------------------------
# HISTOGRAMA DE VALORES
# ----------------------------
st.subheader("🔍 Distribuição de Valores dos Pedidos")
fig3 = px.histogram(dados_filtrados, x='valor_total', nbins=20, title='Distribuição dos Valores dos Pedidos')
st.plotly_chart(fig3, use_container_width=True)

# ----------------------------
# CORRELAÇÃO ENTRE VARIÁVEIS
# ----------------------------
st.subheader("📈 Correlação entre Variáveis")
st.dataframe(dados_filtrados[['quantidade', 'preco_unitario', 'valor_total']].corr())

st.success("App em modo totalmente offline carregado com sucesso 🚀")