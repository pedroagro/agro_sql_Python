
import pandas as pd
import matplotlib.pyplot as plt

# ----------------------------
# Carregando os dados CSV
# ----------------------------
clientes = pd.read_csv("clientes.csv")
produtos = pd.read_csv("produtos.csv")
pedidos = pd.read_csv("pedidos.csv")
itens = pd.read_csv("itens_pedido.csv")

# ----------------------------
# Preparando os dados
# ----------------------------
df = pedidos.merge(clientes, on="id_cliente")
df = df.merge(itens, on="id_pedido")
df = df.merge(produtos, on="id_produto")

df["data_pedido"] = pd.to_datetime(df["data_pedido"])
df["mes"] = df["data_pedido"].dt.to_period("M").astype(str)
df["total_item"] = df["quantidade"] * df["preco_unitario"]

# ----------------------------
# Histograma dos valores totais dos pedidos
# ----------------------------
plt.figure(figsize=(8, 5))
plt.hist(df["valor_total"], bins=10, color="skyblue", edgecolor="black")
plt.title("Distribuição dos Valores dos Pedidos")
plt.xlabel("Valor Total")
plt.ylabel("Frequência")
plt.grid(True)
plt.tight_layout()
plt.show()

# ----------------------------
# Scatter plot - Quantidade vs Preço Unitário
# ----------------------------
plt.figure(figsize=(8, 5))
plt.scatter(df["quantidade"], df["preco_unitario"], c="purple")
plt.title("Preço Unitário vs Quantidade")
plt.xlabel("Quantidade")
plt.ylabel("Preço Unitário")
plt.grid(True)
plt.tight_layout()
plt.show()

# ----------------------------
# Boxplot - Preço por Categoria
# ----------------------------
plt.figure(figsize=(8, 5))
df.boxplot(column="preco", by="categoria", grid=False)
plt.title("Boxplot de Preço por Categoria")
plt.suptitle("")
plt.xlabel("Categoria")
plt.ylabel("Preço")
plt.tight_layout()
plt.show()

# ----------------------------
# Tendência de vendas por mês
# ----------------------------
vendas_mensais = df.groupby("mes")["valor_total"].sum()
plt.figure(figsize=(8, 5))
vendas_mensais.plot(marker="o", linestyle="-", color="green")
plt.title("Tendência de Vendas Mensais")
plt.xlabel("Mês")
plt.ylabel("Total de Vendas")
plt.grid(True)
plt.tight_layout()
plt.show()
