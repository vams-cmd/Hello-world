FROM adoptopenjdk/openjdk8:alpine-slim
MAINTAINER VAMSI
WORKDIR /opt/app
COPY target/demoapp-0.0.1-SNAPSHOT.jar .
EXPOSE 8080
ENV JAVA_OPTIONS ''
CMD java $JAVA_OPTIONS -jar demoapp-0.0.1-SNAPSHOT.jar

