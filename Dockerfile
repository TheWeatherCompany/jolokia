FROM maven:3-openjdk-8 AS build
COPY ./ /app/
RUN cd /app && mvn -B -DskipTests package --projects agent/war-unsecured --also-make

FROM tomcat:9-jdk8-openjdk-slim
ENV JOLOKIA_JSR160_PROXY_ENABLED=true
COPY setenv.sh bin/
COPY --from=build /app/agent/war-unsecured/target/jolokia-war* webapps/jolokia/

EXPOSE 8080
