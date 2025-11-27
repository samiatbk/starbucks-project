FROM node:22-alpine as builder
WORKDIR /app
COPY package*.json ./ 
RUN npm install
COPY . .
RUN npm run build

FROM node:22-alpine
WORKDIR /app
COPY --from=builder /app/build ./build
RUN npm install -g serve
EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=3s \
    CMD curl -f http://localhost:3000/ || exit 1

# Start the server
CMD ["serve", "-s", "build", "-l", "3000"]



