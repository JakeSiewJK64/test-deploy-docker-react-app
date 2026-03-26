FROM node:24.14.0-alpine AS dev

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

# Ensure the “node” user owns the application files. 
# This prevents permission errors when installing 
# dependencies or writing build artifacts inside the container.
RUN chown -R node:node /app

# Switches to the built-in non-root “node” user provided by the
# official Node.js image, improving security by avoiding root 
# privileges inside the container.
USER node

EXPOSE 5173

CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]
