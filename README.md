# anketo_channel

## Build Setup

- 親ディレクトリにdocker-compose.ymlを配置
```
version: '3'
services:
  db:
    image: mysql:5.7.27
    restart: always
    volumes:
      - db-data:/var/lib/mysql
    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
  backend:
    build: ./anketo_channel_api
    ports:
      - ${BACKEND_PORT}:3000
    command: /bin/sh -c "rm -f /app/tmp/pids/server.pid && bundle exec rails s -b ${BACKEND_HOST}"
    volumes:
      - ./anketo_channel_api:/app
      - anketo_channel_api-bundle:/usr/local/bundle
    environment:
      - HOST=${BACKEND_HOST}
      - PORT=${BACKEND_PORT}
    depends_on:
      - db
    tty: true
    stdin_open: true
  frontend:
    build: ./anketo_channel
    ports:
      - ${FRONTEND_PORT}:8080
    command: /bin/sh -c "yarn dev"
    volumes:
      - ./anketo_channel:/app
      - anketo_channel-node_modules:/app/node_modules
    environment:
      - HOST=${FRONTEND_HOST}
      - PORT=${FRONTEND_PORT}
    tty: true
volumes:
  db-data:
  anketo_channel_api-bundle:
  anketo_channel-node_modules:

```

```bash
# サービス起動
$ docker-compose up -d
```
