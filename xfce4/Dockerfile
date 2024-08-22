# syntax=docker/dockerfile:1
FROM ubuntu:latest
LABEL org.opencontainers.image.authors="jisreal@icllc.cc"
LABEL org.opencontainers.image.title="x2go Ubuntu XFCE4"
LABEL org.opencontainers.image.description="Docker image of latest Ubuntu with x2go server and XFCE4 Desktop"

RUN apt-get update -y && apt-get upgrade -y

ENV DEBIAN_FRONTEND=noninteractive

# Upstart and DBus have issues inside docker. We work around in order to install firefox.
#RUN dpkg-divert --local --rename --add /sbin/initctl && ln -sf /bin/true /sbin/initctl

# Installing fuse package (libreoffice-java dependency) and it's going to try to create
# a fuse device without success, due the container permissions. || : help us to ignore it. 
# Then we are going to delete the postinst fuse file and try to install it again!
#RUN apt-get -y install fuse  || :
#RUN rm -rf /var/lib/dpkg/info/fuse.postinst
#RUN apt-get -y install fuse wget

# Language/locale settings
ENV LANG=en_US.UTF-8
RUN echo $LANG UTF-8 > /etc/locale.gen && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y \
     locales && \
    update-locale --reset LANG=$LANG

RUN apt-get install -y sudo openssh-server xfce4 software-properties-common python3-software-properties

# remove snaps
RUN env DEBIAN_FRONTEND=noninteractive apt-get purge snapd -y
RUN env DEBIAN_FRONTEND=noninteractive apt-get autoremove --purge -y

RUN add-apt-repository ppa:x2go/stable -y

RUN apt-get update

RUN apt-get install x2goserver x2goserver-xsession pwgen pulseaudio libappindicator3-1 -y

# fix firefox to install from deb NOT SNAP
RUN add-apt-repository ppa:mozillateam/ppa -y
RUN echo "Package: firefox*" >> /etc/apt/preferences.d/mozillafirefoxppa
RUN echo "Pin: release o=LP-PPA-mozillateam" >> /etc/apt/preferences.d/mozillafirefoxppa
RUN echo "Pin-Priority: 501" >> /etc/apt/preferences.d/mozillafirefoxppa
RUN echo " " >> /etc/apt/preferences.d/mozillafirefoxppa
RUN echo "Package: firefox*" >> /etc/apt/preferences.d/mozillafirefoxppa
RUN echo "Pin: release o=Ubuntu" >> /etc/apt/preferences.d/mozillafirefoxppa
RUN echo "Pin-Priority: -1" >> /etc/apt/preferences.d/mozillafirefoxppa

RUN apt-get update
RUN env DEBIAN_FRONTEND=noninteractive apt-get install -y firefox

RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config
RUN sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config
RUN sed -i "s/#PasswordAuthentication/PasswordAuthentication/g" /etc/ssh/sshd_config

ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh

EXPOSE 22

CMD ["/run.sh"]
