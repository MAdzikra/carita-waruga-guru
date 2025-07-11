FROM eclipse-temurin:21-jdk

RUN apt-get update && apt-get install -y unzip curl && rm -rf /var/lib/apt/lists/*

RUN curl -L -o fuseki.zip https://dlcdn.apache.org/jena/binaries/apache-jena-fuseki-5.4.0.zip && \
    unzip fuseki.zip && mv apache-jena-fuseki-5.4.0 fuseki && rm fuseki.zip

WORKDIR /fuseki

COPY fuseki-config.ttl config.ttl
COPY ontologi_CWG.ttl ontologi_CWG.ttl

EXPOSE 3030

CMD ["./fuseki-server", "--config=config.ttl", "--port=3030"]
