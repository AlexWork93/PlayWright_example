# Use an official Node runtime as a parent image
FROM node:16

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install Playwright dependencies
RUN npx playwright install

# Create npm-global directory, change ownership, and set npm prefix
RUN mkdir -p /home/node/.npm-global \
    && chown -R node:node /home/node/.npm-global \
    && npm config set prefix /home/node/.npm-global

# Set the user to node
USER node

# Set the PATH to include npm-global binaries
ENV PATH=/home/node/.npm-global/bin:$PATH

# Set npm prefix
RUN npm config set prefix /home/node/.npm-global

# Install global npm packages
RUN npm install -g allure-commandline cucumber

# Set the user back to node
USER node

# Change ownership of the working directory
RUN chown -R node:node /usr/src/app

# Print container ID
CMD ["sh", "-c", "echo 'Container ID: ' && cat /proc/self/cgroup | grep 'docker' | sed 's/^.*\///'"]
