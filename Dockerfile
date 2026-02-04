# Dockerfile para Site Estático WordPress - Cloud Run
FROM nginx:alpine

# Informações do mantenedor
LABEL maintainer="Vinicius"
LABEL description="Site estático WordPress - Amado Maker - Cloud Run"

# Remove a configuração padrão do Nginx
RUN rm /etc/nginx/conf.d/default.conf

# Copia a configuração customizada do Nginx
COPY nginx.conf /etc/nginx/conf.d/

# Copia os arquivos estáticos para o diretório do Nginx
COPY . /usr/share/nginx/html/

# Ajusta permissões (Cloud Run não roda como root)
RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html && \
    chown -R nginx:nginx /var/cache/nginx && \
    chown -R nginx:nginx /var/log/nginx && \
    chmod -R 755 /var/cache/nginx && \
    chmod -R 755 /var/log/nginx

# Cria diretório para o PID do Nginx com permissões corretas
RUN touch /var/run/nginx.pid && \
    chown -R nginx:nginx /var/run/nginx.pid

# Expõe a porta 8080 (padrão do Cloud Run)
EXPOSE 8080

# Health check ajustado para porta 8080
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --quiet --tries=1 --spider http://localhost:8080/ || exit 1

# Roda como usuário não-root (requisito do Cloud Run)
USER nginx

# Comando para iniciar o Nginx
CMD ["nginx", "-g", "daemon off;"]