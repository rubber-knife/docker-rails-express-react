FROM node:alpine

WORKDIR /client

COPY package*.json ./
COPY yarn.lock ./

RUN npm install

CMD [ "npm", "start" ]
