FROM node:latest as builder
WORKDIR /app
COPY package.json .
COPY package-lock.json .
RUN npm install
COPY . .
RUN npm run build --silent

FROM nginx:latest
# Nginx config
RUN rm -rf /etc/nginx/conf.d
COPY nginx /etc/nginx/conf.d
# Static build
COPY --from=builder /app/dist/frontend/browser/ /usr/share/nginx/html/
EXPOSE 80

