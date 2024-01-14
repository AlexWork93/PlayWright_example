FROM node:16

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install
RUN apt-get update && apt-get install -y openjdk-11-jdk
RUN apt-get update && apt-get install -y nano
RUN npm install -g allure-commandline
RUN npm install -g cucumber
RUN npx playwright install
RUN echo "Y" | apt-get install libnss3
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

COPY . .

CMD ["npm", "test"]