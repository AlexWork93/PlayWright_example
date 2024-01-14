# Use the official Node.js image with tag 16
FROM node:16

# Set the working directory to /usr/src/app
WORKDIR /usr/src/app

# Copy only the package files to leverage Docker cache
COPY package*.json ./

# Change ownership of the directory to the node user
RUN chown -R node:node /usr/src/app

# Switch to the node user
USER node

# Install dependencies, including global packages
RUN npm install --unsafe-perm

# Switch back to the root user for the following installations
USER root

# Switch back to the default npm prefix
ENV NPM_CONFIG_PREFIX=/usr/local

# Install additional dependencies
RUN apt-get update && apt-get install -y openjdk-11-jdk nano

# Install global npm packages
RUN npm install -g allure-commandline cucumber

# Create and set ownership for Playwright cache directory
RUN mkdir -p /root/.cache/ms-playwright
RUN chown -R node:node /root/.cache/ms-playwright

# Switch back to the node user
USER node

# Install Playwright browsers
RUN npx playwright install

# Install additional dependencies
USER root
RUN echo "Y" | apt-get install -y libnss3 libnspr4 libdbus-1-3 libatk1.0-0 libatk-bridge2.0-0 libcups2 libdrm2 libxkbcommon0 libxcomposite1 libxdamage1 libxfixes3 libxrandr2 libgbm1 libasound2

# Switch back to the node user
USER node

# Copy the rest of the application code
COPY . .

# Command to run when the container starts
CMD ["npm", "test"]


