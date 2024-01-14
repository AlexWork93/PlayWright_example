# Use the official Node.js image with tag 16
FROM node:16

# Set the working directory to /usr/src/app
WORKDIR /usr/src/app

# Copy only the package files to leverage Docker cache
COPY package*.json ./

# Install Playwright browsers and dependencies
RUN npx playwright install

# Set npm prefix to a directory where the node user has write permissions
RUN mkdir -p /home/node/.npm-global \
    && chown -R node:node /home/node/.npm-global \
    && npm config set prefix /home/node/.npm-global

# Switch to the node user
USER node

# Install global npm packages
RUN npm install -g allure-commandline cucumber

# Install application dependencies
RUN npm install

# Change ownership of the entire /usr/src/app directory to the node user
RUN chown -R node:node /usr/src/app

# Command to run when the container starts
CMD ["npm", "test"]