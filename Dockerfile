FROM jbangdev/jbang-action AS build

RUN mkdir /app
WORKDIR /app
COPY . /app

RUN jbang export portable --verbose --force --java 11 src/telescopeComplianceRhacs.java

FROM registry.access.redhat.com/ubi8/openjdk-17:1.14
USER root
RUN mkdir /app/
RUN mkdir /app/lib
COPY --from=build /app/telescopeComplianceRhacs.jar /app/telescopeComplianceRhacs.jar
COPY --from=build lib/* /app/lib/
WORKDIR /app
#CMD "java" "-jar" "/app/telescopeComplianceRhacs.jar"
