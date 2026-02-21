FROM node:20-alpine

# Set working directory
WORKDIR /app

# Copy package files first
COPY package*.json ./

# Install only production dependencies
RUN npm install --production

# Copy app source
COPY src/index.js .

# Expose app port
EXPOSE 3000

# Run app
CMD ["node", "index.js"]