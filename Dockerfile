# Use the official Bun image as the base image
FROM oven/bun:latest as build

# Set the working directory
WORKDIR /app

# Copy the package.json file
COPY package.json ./

# Install dependencies with Bun
RUN bun install

# Copy the rest of the application code
COPY . .

# Build the application
RUN bun run build

# Use a smaller image for the final container
FROM oven/bun:latest

WORKDIR /app

# Copy built assets from the build stage
COPY --from=build /app/dist ./dist
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/package.json ./

# Expose the port that the app runs on
EXPOSE 3000

# Command to run the application
CMD ["bun", "run", "start"]
