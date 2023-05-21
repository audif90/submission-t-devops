FROM node:lts-slim
WORKDIR /app
COPY . /
RUN npm install
EXPOSE 8080
CMD [ "npm", "run", "start" ]