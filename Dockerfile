FROM node:slim
#Create Directory
RUN mkdir -p /home/app
#Copy app and dependencies content Directory
COPY index.js /home/app
COPY package.json /home/app
#Switch to working directory so that next command will run in required directory
WORKDIR /home/app
#install dependencis
RUN npm install
#Application running on port 3000 so expose port.
EXPOSE 3000
#Start server
CMD [ "node", "index.js" ]