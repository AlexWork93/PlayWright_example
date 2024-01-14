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

# Install dependencies, excluding fsevents
RUN npm install --unsafe-perm --ignore-scripts --no-optional

# Create and set ownership for Playwright cache directory
RUN mkdir -p /home/node/.cache/ms-playwright
RUN chown -R node:node /home/node/.cache/ms-playwright

# Switch back to the root user for the following installations
USER root

# Switch back to the default npm prefix
ENV NPM_CONFIG_PREFIX=/usr/local

# Install additional dependencies
RUN apt-get update && apt-get install -y openjdk-11-jdk nano

# Install global npm packages
RUN npm install -g allure-commandline cucumber

# Switch back to the node user
USER node

# Change ownership of the entire /usr/src/app directory to the node user
RUN chown -R node:node /usr/src/app

# Install dependencies
RUN npm install --unsafe-perm --ignore-scripts --no-optional --no-bin-links

# Install Playwright browsers
RUN npx playwright install

# Switch back to the node user
USER node

# Copy the rest of the application code
COPY . .

# Command to run when the container starts
CMD ["npm", "test"]
