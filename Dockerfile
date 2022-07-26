FROM ubuntu:22.04

RUN apt-get update && apt-get upgrade -y && apt-get install default-jdk wget -y

RUN wget https://archive.apache.org/dist/lucene/solr/8.9.0/solr-8.9.0.tgz

RUN tar xzf solr-8.9.0.tgz

RUN bash solr-8.9.0/bin/install_solr_service.sh solr-8.9.0.tgz

RUN apt-get install lsof -y

COPY --chown=solr:solr cores/posts /var/solr/data/posts

RUN mkdir /var/solr/lib && chown solr:solr /var/solr/lib

COPY --chown=solr:solr jdbc/postgresql-42.4.0.jar /var/solr/lib/

EXPOSE 8983

ENTRYPOINT [ "/usr/sbin/init" ]