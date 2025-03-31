# 📊 Dashboard de Vendas

Este é um projeto de dashboard interativo feito com **Python**, **Streamlit** e **Pandas**, com análise exploratória utilizando **Matplotlib** e **Plotly**, e integração opcional com **PostgreSQL**.

---

## ✅ Funcionalidades

- 📈 Visualização de vendas por mês
- 🏅 Ranking de clientes por faturamento
- 📦 Análise de produtos e categorias
- 📊 Gráficos interativos com Plotly
- 📉 Análise estatística com Matplotlib
- 💾 Funciona totalmente **offline** com arquivos CSV

---

## 📁 Estrutura de arquivos

```bash
dashboard-vendas/
├── app.py                     # Aplicativo principal Streamlit
├── analise_exploratoria.py    # Script de análise com matplotlib
├── clientes.csv
├── produtos.csv
├── pedidos.csv
├── itens_pedido.csv
├── requirements.txt           # Dependências
└── README.md                  # Este arquivo
```

---

## 🚀 Como rodar o projeto

### 1. Clone o repositório

```bash
git clone https://github.com/seu_usuario/dashboard-vendas.git
cd dashboard-vendas
```

### 2. Instale as dependências

```bash
pip install -r requirements.txt
```

### 3. Rode o dashboard (modo offline com CSV)

```bash
streamlit run app.py
```

### 4. Rode a análise estatística

```bash
python analise_exploratoria.py
```

---

## 🛢️ Integração com PostgreSQL (opcional)

Você pode usar os dados no banco PostgreSQL. Um script com criação de tabelas e inserção de dados fictícios está disponível:

📄 `script_vendas_utf8.sql`

---

## 📊 Tecnologias usadas

- Python
- Streamlit
- Pandas
- Matplotlib
- Plotly
- PostgreSQL (opcional)
