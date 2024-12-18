# Base image
FROM node:16

# Update system and install dependencies
RUN apt-get update && \
    apt-get install -y build-essential 

# Set working directory
WORKDIR /app

# Copy package and lock files first (cache layer for dependencies)
COPY package.json package-lock.json ./

# Install npm dependencies
RUN npm install && \
    npm install --save-dev @types/express @types/node
    
# Copy all source files into the container
COPY . .

# Build the application
RUN npm run build

# Expose application port
EXPOSE 8080

# Run the application
CMD ["npm", "start"]
