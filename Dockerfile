FROM nginx:alpine
# Information about the image
LABEL maintainer="Vinicius"
LABEL description="Site estático WordPress - Amado Maker - Cloud Run"
# Remove nginx default config
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/
# Copy the static files to the nginx html directory
COPY . /usr/share/nginx/html/
RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html && \
    chown -R nginx:nginx /var/cache/nginx && \
    chown -R nginx:nginx /var/log/nginx && \
    chmod -R 755 /var/cache/nginx && \
    chmod -R 755 /var/log/nginx
# Create the nginx.pid file and set permissions
RUN touch /var/run/nginx.pid && \
    chown -R nginx:nginx /var/run/nginx.pid
EXPOSE 8080
# Health check for Cloud Run
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --quiet --tries=1 --spider http://localhost:8080/ || exit 1
USER nginx
CMD ["nginx", "-g", "daemon off;"]