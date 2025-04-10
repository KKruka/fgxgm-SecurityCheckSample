FROM python:3.14-rc-alpine3.20

# Install necessary dependencies and your application steps
RUN pip install --no-cache-dir -r requirements.txt

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
