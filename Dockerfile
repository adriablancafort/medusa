FROM node:aplpine

WORKDIR /app

COPY package.json yarn.lock ./

RUN yarn install

COPY . .

RUN npx medusa db:create

RUN npx medusa user --email asilormail@gmail.com --password password

RUN yarn seed

RUN npx medusa db:migrate

RUN npx medusa build

RUN npx medusa telemetry --disable

EXPOSE 9000

CMD ["npx", "medusa", "start"]