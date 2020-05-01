FROM tomcat:9-jdk8-openjdk-slim
ENV JOLOKIA_JSR160_PROXY_ENABLED=true
COPY setenv.sh bin/
COPY agent/war-unsecured/target/jolokia-war* webapps/jolokia/

EXPOSE 8080
