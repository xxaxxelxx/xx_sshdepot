FROM debian:jessie
MAINTAINER xxaxxelxx <x@axxel.net>

#RUN sed -e 's/$/ contrib non-free/' -i /etc/apt/sources.list 

RUN apt-get -qq -y update
RUN apt-get -qq -y dist-upgrade

ENV TERM=xterm
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -qq -y install ssh
RUN apt-get -qq -y install sudo
RUN apt-get -qq -y install rsync
RUN apt-get -qq -y install mc

# clean up
RUN apt-get clean

RUN mkdir /var/run/sshd

RUN useradd -m -g nogroup sshrw
RUN useradd -m -g nogroup sshro
RUN sudo -u sshrw mkdir /home/sshrw/.ssh
RUN sudo -u sshro mkdir /home/sshro/.ssh
COPY authorized_keys2 /home/sshrw/.ssh/
COPY authorized_keys2 /home/sshro/.ssh/
RUN chown -R sshrw:nogroup /home/sshrw/.ssh
RUN chown -R sshro:nogroup /home/sshro/.ssh
RUN sudo -u sshrw chmod -R 700 /home/sshrw/.ssh
RUN sudo -u sshro chmod -R 700 /home/sshro/.ssh

RUN mkdir -p /icecastwebdirectory
RUN chown sshrw /icecastwebdirectory
RUN chmod 705 /icecastwebdirectory

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
#CMD [ "bash" ]
