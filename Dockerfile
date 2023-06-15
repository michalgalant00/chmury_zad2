# na bazie obrazu node:alpine
FROM node:alpine as builder
# wprowadzenie zmiennej środowiskowej do obrazu
ENV NODE_OPTIONS=--openssl-legacy-provider
# ustawienie katalogu roboczego
WORKDIR '/app'
# sekcja z kopiowaniem i budowaniem projektu z zależnościami
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# na bazie obrazu nginx wystawienie zbudowanej aplikacji
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html