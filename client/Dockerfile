# Step 1: Use a Node.js base image
FROM node:18-alpine AS build

# Step 2: Set the working directory
WORKDIR /app

# Step 3: Copy package.json and yarn.lock
COPY package.json yarn.lock ./

# Step 4: Install dependencies
RUN yarn install

# Step 5: Copy the rest of the application
COPY . .

# Step 6: Build the frontend
RUN yarn build

# Step 7: Use a lightweight web server to serve the frontend
FROM nginx:alpine

# Step 8: Copy the built files to the Nginx server
COPY --from=build /app/dist /usr/share/nginx/html

# Step 9: Copy custom Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Step 10: Expose the port the app will run on (default Vite port is 5173)
EXPOSE 5173

# Step 11: Start the Nginx server
CMD ["nginx", "-g", "daemon off;"]