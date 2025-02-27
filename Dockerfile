# Build stage
FROM oven/bun:latest as build

WORKDIR /app

# Copy package.json and install dependencies
COPY package.json bun.lockb* ./
RUN bun install --frozen-lockfile

# Copy the rest of the application
COPY . .

# Build the application
RUN bun run build

# Production stage
FROM oven/bun:latest as production

WORKDIR /app

# Copy built files from the build stage
COPY --from=build /app/dist ./dist
COPY --from=build /app/package.json ./

# Install only production dependencies
RUN bun install --production

# Expose port
EXPOSE 3000

# Start the application
CMD ["bun", "preview", "--host", "0.0.0.0"]