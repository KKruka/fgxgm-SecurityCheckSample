FROM node:18.21.0
FROM python:3.14-rc-alpine3.20

# Other steps in your Dockerfile

RUN pip install --no-cache-dir -r requirements.txt
RUN npm install -g npm@9.1.3

ADD package.json .
ADD index.js .
ADD build .
COPY . .
RUN npm install

EXPOSE 8080

CMD [ "node", "index.js" ]
