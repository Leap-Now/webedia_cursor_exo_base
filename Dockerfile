# Base stage with Node.js and pnpm
FROM node:20-alpine AS base

# Install pnpm
RUN corepack enable && corepack prepare pnpm@10.15.1 --activate

WORKDIR /app

# Dev stage - installs dependencies, sources mounted as volume
FROM base AS development

# install zsh
RUN apk add --no-cache zsh

# Set MOVIE_ID for runtime data fetching
ARG MOVIE_ID
ENV MOVIE_ID=${MOVIE_ID}

# Expose Eleventy dev server port
EXPOSE 8080 5173

# Start dev server (sources will be mounted as volume)
CMD ["pnpm", "start"]

# Build stage - builds the site for production
FROM base AS builder

# Copy package files
COPY package.json pnpm-lock.yaml .npmrc ./

# Install dependencies with NPM_TOKEN from build arg
ARG NPM_TOKEN
ENV NPM_TOKEN=${NPM_TOKEN}
RUN pnpm install --frozen-lockfile

# Set MOVIE_ID for build-time data fetching
ARG MOVIE_ID
ENV MOVIE_ID=${MOVIE_ID}

# Copy source files
COPY . .

# Build the site
RUN pnpm build

# Production stage - serves built static files
FROM nginx:alpine AS production

# Copy built site to nginx html directory
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]

