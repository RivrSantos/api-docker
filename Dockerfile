FROM python:3.13.4-alpine3.22

# Define o diretório de trabalho no contêiner
WORKDIR /app

# Copia o arquivo de dependências primeiro para aproveitar o cache do Docker
# Se o requirements.txt não mudar, o Docker não reinstalará as dependências
COPY requirements.txt .

# Instala as dependências
# --no-cache-dir reduz o tamanho da imagem
RUN pip install --no-cache-dir -r requirements.txt

# Copia o resto do código da aplicação para o diretório de trabalho
COPY . .

# Expõe a porta em que a aplicação será executada
EXPOSE 8000

# Comando para executar a aplicação
# Usando gunicorn, que é um servidor WSGI padrão para produção.
# Substitua 'app:app' por 'nome_do_arquivo:nome_da_variavel_da_app' se for diferente.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
