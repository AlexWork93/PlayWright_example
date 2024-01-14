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

# Install Playwright browsers
RUN npx playwright install

# Switch back to the root user for the following installations
USER root

# Install additional dependencies
RUN apt-get update && apt-get install -y openjdk-11-jdk nano

# Install global npm packages
RUN npm install -g allure-commandline cucumber

# Switch back to the node user
USER node

# Change ownership of the entire /usr/src/app directory to the node user
RUN chown -R node:node /usr/src/app

# Command to run when the container starts
CMD ["npm", "test"]
