# docker build . + docker run -p 8080:80 <image_id>
# 1st build phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
# no volumes cause in prod
COPY . .
RUN npm run build
# the ouput will be the build folder
# /app/build <-- dir inside the container

# 2nd run phase
FROM nginx
# copy from a different phase specifying also the folder to copy and move in a static folder /html
COPY --from=builder /app/build /usr/share/nginx/html