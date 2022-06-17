FROM node:12.18.4

RUN npm install -g http-server
# Create app directory
WORKDIR /app


# Copy a .env file
COPY * ./

# Install app dependencies
RUN npm install 
# Bundle app source
COPY . .

RUN npm run build
EXPOSE 8080

CMD [ "http-server", "dist" ]