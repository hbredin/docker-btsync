# BUILD-USING:        docker build -t btsync .
# RUN-USING:          docker run -d -p 8080:80 -p 55555:55555 -volumes-from DATA -v $PWD:/btsync -v /home/bredin/app/btsync:/var/app/btsync -name BTSYNC btsync

FROM ubuntu

MAINTAINER Herve Bredin (http://herve.niderb.fr)

# Install curl
RUN apt-get update && apt-get install -y curl

# Download and extract the executable to /usr/bin
RUN curl -o /usr/bin/btsync.tar.gz http://download-lb.utorrent.com/endpoint/btsync/os/linux-x64/track/stable
RUN cd /usr/bin && tar -xzvf btsync.tar.gz && rm btsync.tar.gz 

# Web GUI
EXPOSE 80

# Listening port
EXPOSE 55555

VOLUME ["/var/app/btsync"]

ENTRYPOINT ["btsync"]
CMD ["--config", "/btsync/btsync.conf", "--nodaemon"]
