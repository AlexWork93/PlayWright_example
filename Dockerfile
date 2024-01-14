# Use an official Node.js runtime as a parent image
FROM node:16

# Set the working directory to /usr/src/app
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install Playwright dependencies
RUN npx playwright install

# Create a directory for the npm global packages
RUN mkdir -p /home/node/.npm-global

# Change the owner of the npm global directory to the node user
RUN chown -R node:node /home/node/.npm-global

# Set the npm global directory as the prefix for npm packages
USER node
ENV PATH=/home/node/.npm-global/bin:$PATH
RUN npm config set prefix /home/node/.npm-global

# Install global npm packages
RUN npm install -g allure-commandline cucumber

# Copy the local source files to the container
COPY . .

# Make port 8080 available to the world outside this container
EXPOSE 8080

# Run app.js when the container launches
CMD ["node", "app.js"]