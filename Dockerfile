FROM node:16

WORKDIR /usr/src/app

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
RUN apt-get update && apt-get install -y openjdk-11-jdk
RUN apt-get update && apt-get install -y nano
RUN npm install -g allure-commandline
RUN npm install -g cucumber
RUN mkdir -p /root/.cache/ms-playwright
RUN chown -R node:node /root/.cache/ms-playwright
USER node
RUN npx playwright install

USER root
RUN echo "Y" | apt-get install -y libnss3
RUN echo "Y" | apt-get install libnspr4
RUN echo "Y" | apt-get install libdbus-1-3
RUN echo "Y" | apt-get install libatk1.0-0
RUN echo "Y" | apt-get install libatk-bridge2.0-0
RUN echo "Y" | apt-get install libcups2
RUN echo "Y" | apt-get install libdrm2
RUN echo "Y" | apt-get install libxkbcommon0
RUN echo "Y" | apt-get install libxcomposite1
RUN echo "Y" | apt-get install libxdamage1
RUN echo "Y" | apt-get install libxfixes3
RUN echo "Y" | apt-get install libxrandr2
RUN echo "Y" | apt-get install libgbm1
RUN echo "Y" | apt-get install libasound2
USER node

COPY . .

CMD ["npm", "test"]

