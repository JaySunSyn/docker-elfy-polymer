FROM debian:jessie
MAINTAINER Jalal Fathi "jfathi.mail@gmail.com"

# NodeJS, Git, bzip2
RUN apt-get update && \
    apt-get -y install curl && \
    curl -sL https://deb.nodesource.com/setup_0.12 | bash - && \
    apt-get -y install nodejs git bzip2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Gulp, bower
RUN npm update npm -g
RUN npm install -g gulp bower

# Source
ADD bower.json /bower.json
ADD gulpfile.js /gulpfile.js
ADD package.json /package.json

# Dependencies
RUN bower install --allow-root --config.interactive=false -s
RUN npm install
# Scripts
ADD dev.sh /dev.sh
RUN chmod +x /dev.sh

CMD ["/dev.sh"]