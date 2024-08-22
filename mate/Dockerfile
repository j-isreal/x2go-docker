# syntax=docker/dockerfile:1
ARG VER=jammy
FROM ubuntu:$VER
ENV SHELL=/bin/bash

LABEL org.opencontainers.image.authors="jisreal@icllc.cc"
LABEL org.opencontainers.image.title="x2go Ubuntu Mate"
LABEL org.opencontainers.image.description="Docker image of Ubuntu 22.04 with x2go server and Mate Desktop"

RUN apt-get update -y && apt-get upgrade -y

#ENV DEBIAN_FRONTEND=noninteractive

RUN env DEBIAN_FRONTEND=noninteractive apt-get install -y \
      dbus-x11 \
      procps \
      psmisc && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y \
      xdg-utils \
      xdg-user-dirs \
      menu-xdg \
      mime-support \
      desktop-file-utils \
      bash-completion && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y \
      mesa-utils-extra \
      libxv1 \
      sudo \
      lsb-release \
      openssh-server \
      wget


# Language/locale settings
ENV LANG=en_US.UTF-8
#ENV LANG=en_US.utf8
RUN echo $LANG UTF-8 > /etc/locale.gen && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y \
     locales && \
    lsb_release -cs | grep -qE "precise|trusty" && locale-gen $LANG || update-locale --reset LANG=$LANG


# Ubuntu MATE desktop install
# * package for 12.04 LTS and 14.04 LTS
# * task for 16.04 LTS and newer versions
RUN if lsb_release -cs | grep -qE "precise|trusty"; then \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y \
      ubuntu-mate-desktop --force-yes; \
    else \
      env DEBIAN_FRONTEND=noninteractive apt-get install -y \
      ubuntu-mate-desktop^; \
    fi

# 22.04 LTS specifics - only for amd64, WILL ERROR on arm64
#RUN echo "Warning: it is jammy, will use workarounds!" && \
#      env DEBIAN_FRONTEND=noninteractive apt autopurge -y \
#      acpid acpi-support

# remove mate-screensaver
RUN env DEBIAN_FRONTEND=noninteractive apt-get purge mate-screensaver -y
RUN env DEBIAN_FRONTEND=noninteractive apt-get autoremove --purge -y

# add x2go PPA, update apt and install x2goserver and web browsers
RUN add-apt-repository ppa:x2go/stable
RUN apt-get update

RUN env DEBIAN_FRONTEND=noninteractive apt-get install -y \
      x2goserver \
      x2goserver-xsession \
      pwgen && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y \
      firefox \
      chromium-browser

# update sshd_config
RUN sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config
RUN sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config
RUN sed -i "s/#PasswordAuthentication/PasswordAuthentication/g" /etc/ssh/sshd_config

# add files to image and make executable
ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh

# port 22 for ssh
EXPOSE 22

CMD ["/run.sh"]
