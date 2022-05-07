FROM node:16-alpine as builder

WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=builder ./app/build /usr/share/nginx/html