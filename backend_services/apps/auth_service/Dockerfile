FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npx nest build auth_service
CMD ["node", "dist/apps/auth_service/main.js"]
