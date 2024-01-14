# Use an official Node runtime as a base image
FROM node:16

# Set the working directory to /usr/src/app
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the entire project to the working directory
COPY . .

# Expose the port used by your application (if applicable)
# EXPOSE 3000

# Specify the command to run on container start
CMD ["npm", "test"]