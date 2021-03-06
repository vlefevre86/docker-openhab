#
# Openhab 1.5.0
# * configuration is injected
# * addons:
#
FROM ubuntu:14.04
MAINTAINER vlefevre86 <vlefevre86@gmail.com>

# Install dependencies
RUN apt-get update -y
RUN apt-get install -y openjdk-7-jre unzip

# Download Openhab 1.5.0
ADD https://github.com/openhab/openhab/releases/download/v1.5.0/distribution-1.5.0-runtime.zip /tmp/distribution-1.5.0-runtime.zip
ADD https://github.com/openhab/openhab/releases/download/v1.5.0/distribution-1.5.0-addons.zip /tmp/distribution-1.5.0-addons.zip

# Download HABmin
ADD https://github.com/cdjackson/HABmin/releases/download/0.1.3-snapshot/habmin.zip /tmp/habmin.zip

# Install Openhab 1.5.0
RUN mkdir -p /opt/openhab/addons-avail
RUN unzip -d /opt/openhab /tmp/distribution-1.5.0-runtime.zip
RUN unzip -d /opt/openhab/addons-avail /tmp/distribution-1.5.0-addons.zip
RUN chmod +x /opt/openhab/start.sh

# Install HABmin
RUN unzip -d /opt/openhab /tmp/habmin.zip

# Add boot script
ADD files/boot.sh /usr/local/bin/boot.sh
RUN chmod +x /usr/local/bin/boot.sh

EXPOSE 8080 8443

CMD /usr/local/bin/boot.sh
