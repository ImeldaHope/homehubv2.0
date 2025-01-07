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

# Step 6: Build the backend (if needed)
RUN yarn build

# Step 7: Use a Node.js base image for runtime
FROM node:18-alpine AS runtime

# Step 8: Set the working directory
WORKDIR /app

# Step 9: Copy the built files and production dependencies
COPY --from=build /app/dist ./dist
COPY --from=build /app/package.json ./package.json
COPY --from=build /app/yarn.lock ./yarn.lock

# Step 10: Install production dependencies
RUN yarn install --production

# Step 11: Expose the port the backend will run on
EXPOSE 3000

# Step 12: Start the backend server
CMD ["node", "dist/index.js"]