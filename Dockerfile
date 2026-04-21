#rodar comando: docker build -t reshop/client:1.2.30 .
#depois rodar comando: docker container run --name ReshopClient -p 2009:2009 -p 2010:2010 reshop/client:1.2.30
FROM ubuntu:20.04

LABEL version="1.2.30" description="Reshop Client Slot 1" maintainer="Claudio A. Maritnns<claudio.almeida@linx.com.br>"

RUN apt-get update

#RUN apt-get install mono-complete

RUN apt-get install -y wget software-properties-common gnupg2 winbind xvfb

RUN dpkg --add-architecture i386
RUN wget -nc https://dl.winehq.org/wine-builds/winehq.key
RUN apt-key add winehq.key
RUN add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
RUN apt-get update
RUN apt-get install -y winehq-stable

RUN apt-get install -y winetricks

RUN winetricks dotnet45

RUN apt-get clean -y
RUN apt-get autoremove -y

ENV WINEDEBUG=fixme-all

RUN winetricks msxml6

COPY app /root/reshop/client
COPY startup.sh /root/startup.sh
RUN chmod gou+x /root/startup.sh

#EXPOSE 9000

CMD ["/root/startup.sh"]