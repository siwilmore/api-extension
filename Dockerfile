FROM node:14
# Base image and entrypoint provided
# Research npm to discover how to install app and dependencies
COPY . . 
WORKDIR /app
RUN npm install
# Expose the correct port
EXPOSE 80
# Create an entrypoint
ENTRYPOINT ["npm", "start"]