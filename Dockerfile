ARG IMAGE_SRC=maven:3.8.6-jdk-8
FROM $IMAGE_SRC

#USER root
ARG UNAME=slave
ARG UID=1001
ARG GID=1001
 
# Add group to docker image
RUN groupadd -g $GID -o $UNAME
# Add user to docker image
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME

RUN echo $IMAGE_SRC

RUN apt update -y
RUN apt install wget -y

RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN apt install ./google-chrome-stable_current_amd64.deb -y
RUN apt update -y

RUN apt install xvfb -y
RUN apt update -y

RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/*
RUN wget "https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US" -O firefox.tar.bz2
RUN tar xjf ./firefox.tar.bz2
RUN rm -r ./firefox.tar.bz2
RUN mv ./firefox /opt/firefox
RUN ln -s /opt/firefox/firefox /usr/bin/firefox
RUN apt update -y
RUN apt install libdbus-glib-1-2:amd64

RUN firefox --version

RUN apt update -y


RUN mkdir -p /.cache
RUN chmod 777 /.cache
RUN chmod 1000 /tmp/*
RUN chmod 1001 /tmp/*

RUN apt clean