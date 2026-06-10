# start with official ruby docker image as base
FROM ruby:3.1.2

# set working directory within container
WORKDIR /usr/src/app

# pull in ruby (jekyll) package info only
COPY Gemfile Gemfile.lock ./

# install ruby packages
RUN VERSION=$(grep -A 1 'BUNDLED WITH' Gemfile.lock | tail -n 1 | xargs); \
    gem install bundler --version ${VERSION} && \
    bundle _${VERSION}_ install

# install python + pip dulu, baru watchdog
RUN apt update && apt install -y python3 python3-pip && \
    pip3 install "watchdog[watchmedo]==3.0.0"

# ports used by jekyll
EXPOSE 4000
EXPOSE 35729

# run jekyll
COPY .docker/entrypoint.sh /var
CMD [ "/var/entrypoint.sh" ]
