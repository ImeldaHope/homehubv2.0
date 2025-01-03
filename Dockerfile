# Step 1: Use a Node.js base image
FROM node:18-alpine

# Step 2: Set the working directory
WORKDIR /app

# Install Yarn globally
RUN npm install -g yarn

# Step 3: Copy package.json and package-lock.json (or yarn.lock)
COPY package*.json yarn.lock ./ 

# Step 4: Install dependencies
RUN yarn install

# Step 5: Copy the rest of the application
COPY . .

# Step 6: Build the Vite project
RUN yarn build

# Expose the port the app will run on (default Vite port is 5173)
EXPOSE 5173

# Step 7: Set up a server for production
FROM nginx:alpine

# Step 8: Copy the built files to the Nginx server
COPY --from=build /app/dist /usr/share/nginx/html

# Step 9: Expose the default Nginx port
EXPOSE 80

# Step 10: Start the Nginx server
CMD ["nginx", "-g", "daemon off;"]
