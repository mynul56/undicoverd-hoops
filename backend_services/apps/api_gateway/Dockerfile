FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npx nest build api_gateway
CMD ["node", "dist/apps/api_gateway/main.js"]
