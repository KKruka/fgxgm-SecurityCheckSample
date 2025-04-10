# Stage 1: Use Node.js image
FROM node:18.21.0 AS node_build

# Install Node.js dependencies
RUN npm install -g npm@9.1.3

ADD package.json .
ADD index.js .
ADD build .
COPY . .
RUN npm install

# Stage 2: Use Python image
FROM python:3.14-rc-alpine3.20

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the build from the Node.js image to the final image
COPY --from=node_build /app /app

EXPOSE 8080

CMD [ "node", "index.js" ]
