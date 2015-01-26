# This file describes how to build Hipache into a runnable linux container with
# all dependencies installed.
#
# To build:
#
# 1) Install docker (http://docker.io)
# 2) Clone Hipache repo if you haven't already: git clone https://github.com/dotcloud/hipache.git
# 3) Build: cd hipache && docker build .
# 4) Run: docker run -d --name redis redis
# 5) Run: docker run -d --link redis:redis -P <hipache_image_id>
#
# See the documentation for more details about how to operate Hipache.

# Latest Ubuntu LTS
FROM    ubuntu:14.04

# Update
RUN apt-get -y update

# Install node, npm
RUN apt-get -y install nodejs npm

# Manually add hipache folder
RUN mkdir ./hipache
ADD package.json ./app/package.json

# Install npm modules
WORKDIR /app
RUN npm install --production

# This is provisional, as we don't honor it yet in hipache
ENV NODE_ENV production

# Expose hipache
EXPOSE  80

ENTRYPOINT ["/app/bin/hipache"]

# Start supervisor
CMD ["-c", "/app/config/config_dev.json"]

ADD . ./app
