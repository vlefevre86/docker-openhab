#
# Openhab 1.5.0
# * configuration is injected
# * addons:
#
FROM phusion/baseimage:0.9.11
MAINTAINER vlefevre86 <vlefevre86@gmail.com>
ENV DEBIAN_FRONTEND noninteractive

# Set correct environment variables
ENV HOME /root

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Fix a Debianism of the nobody's uid being 65534
RUN usermod -u 99 nobody
RUN usermod -g 100 nobody

# Install dependencies
RUN apt-get update -q
RUN apt-get install -qy openjdk-7-jre unzip curl

# Download Openhab 1.5.0
ADD https://github.com/openhab/openhab/releases/download/v1.5.0/distribution-1.5.0-runtime.zip /tmp/distribution-1.5.0-runtime.zip
ADD https://github.com/openhab/openhab/releases/download/v1.5.0/distribution-1.5.0-addons.zip /tmp/distribution-1.5.0-addons.zip

# Install Openhab 1.5.0
RUN mkdir -p /opt/openhab/addons-avail
RUN unzip -d /opt/openhab /tmp/distribution-1.5.0-runtime.zip
RUN unzip -d /opt/openhab/addons-avail /tmp/distribution-1.5.0-addons.zip
RUN chmod +x /opt/openhab/start.sh

# Add boot script
ADD files/boot.sh /usr/local/bin/boot.sh
RUN chmod +x /usr/local/bin/boot.sh

EXPOSE 8080 8443

CMD /usr/local/bin/boot.sh
