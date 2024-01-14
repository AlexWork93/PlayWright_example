# Use the official Node.js image with tag 16
FROM node:16

# Set the working directory to /usr/src/app
WORKDIR /usr/src/app

# Copy only the package files to leverage Docker cache
COPY package*.json ./

# Switch to the root user for package installation
USER root

# Install Playwright browsers and dependencies
RUN npx playwright install \
    && chown -R node:node /usr/src/app

# Switch back to the node user
USER node

# Install global npm packages
RUN npm install -g allure-commandline cucumber

# Install application dependencies
RUN npm install

# Change ownership of the entire /usr/src/app directory to the node user
RUN chown -R node:node /usr/src/app

# Command to run when the container starts
CMD ["npm", "test"]
