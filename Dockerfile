FROM ubuntu:16.04
MAINTAINER ITSESCDE <schuetz@itsesc.ovh>

RUN useradd -u 1000 mumble \
 && apt-get update \
 && apt-get install -y mumble-server \
 && mkdir /data && chown 1000 /data
 

ADD mumble-server.ini /mumble-server.ini
ADD supw.sh /supw.sh

RUN exec supw.sh

VOLUME ["/data", "/config"]
EXPOSE 64738/udp

USER mumble
ENTRYPOINT ["/usr/sbin/murmurd", "-fg", "-ini", "/config/mumble-server.ini"]
