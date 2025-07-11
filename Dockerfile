# Build stage
FROM node:18-alpine as builder

WORKDIR /app
COPY server/package*.json ./
RUN npm install
COPY server/ .

# Runtime stage
FROM node:18-alpine

WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY server/ .

EXPOSE 3000
CMD ["node", "server.js"]
