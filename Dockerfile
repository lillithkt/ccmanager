FROM node:18-alpine AS builder
RUN npm i -g pnpm
WORKDIR /app
COPY package.json pnpm-lock.yaml .
RUN pnpm install --frozen-lockfile
COPY . .
RUN pnpm run build
CMD ["pnpm", "start"]
