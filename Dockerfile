FROM node:14
WORKDIR /app
COPY . .
RUN npm i
ENV PORT=4000
ENTRYPOINT ["npm", "start"]