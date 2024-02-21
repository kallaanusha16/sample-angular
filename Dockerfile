# Stage 1: Build the Angular application
FROM node:18.17.0 AS build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies

RUN npm install

# Copy project files and folders to the current working directory
COPY . .

# Build the Angular app in production mode
RUN npm run build 

# Stage 2: Serve the Angular application using Nginx
FROM nginx:alpine

# Copy the built app from the previous stage to Nginx directory
COPY --from=build /app/dist/sample-angular/browser   /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
