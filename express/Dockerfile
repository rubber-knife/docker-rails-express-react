FROM node:alpine

RUN npm install nodemon -g

WORKDIR /express

COPY package*.json ./
COPY yarn.lock ./

RUN npm install

CMD [ "nodemon" ]
