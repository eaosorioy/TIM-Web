FROM node:11.15.0-alpine as build-step
LABEL maintainer="eaosorioy@gmail.com"
LABEL maintainer="brayanm.avelez@gmail.com"
WORKDIR /app
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:1.16.0-alpine as prod-stage
COPY --from=build-step /app/dist/WebApp /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]