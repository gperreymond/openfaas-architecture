FROM functions/nodebase:alpine-6.9.1
MAINTAINER Gilles Perreymond <gperreymond@gmail.com>

# Prepare the destination
RUN mkdir -p /usr/app
WORKDIR /usr/app

# Add source files
COPY . /usr/app

# Root user used in docker:dind during CI, cf https://docs.npmjs.com/misc/config
RUN npm config set unsafe-perm true

# Make the install in the container to avoid compilation problems
RUN yarn install --production && \
    yarn autoclean --init && \
    yarn autoclean --force
