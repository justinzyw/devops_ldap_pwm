# refer to https://github.com/pwm-project/pwm/blob/master/docker/src/main/docker/Dockerfile
FROM openjdk:11-ea-24-jre-slim

ARG VERSION=2018-08-07T18_11_51Z

ENV FILE=pwm-onejar-1.8.0-SNAPSHOT.jar

# Install additional packages
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends wget
    
RUN mkdir /config ; mkdir /appliance

# Download & deploy jar
RUN cd /appliance && \
    wget https://www.pwm-project.org/artifacts/pwm/${VERSION}/${FILE}

VOLUME /config
EXPOSE 8443

WORKDIR /appliance
CMD java -server -jar ${FILE} -applicationPath /config
