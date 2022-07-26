# Solr working example

TL;DR This project is a exploratory study of Solr setup and configuration. The key for this exercise is this article: [How to index mysql data in Solr](http://makble.com/how-to-index-mysql-data-in-solr).

## Setup

Edit `conf/db-data-config.xml` with the database address, database name, user and password. By default, this project is setup to work with Postgresql. Also in this file, edit `entity` and `field` entries to match your specific database.

To run Solr:

```bash
docker build -t solr .
docker run -itd --name solr --privileged -p 8983:8983 solr
docker exec solr systemctl enable solr
docker exec solr systemctl start solr
```

Solr will be available at `localhost:8983`.

To ssh into the container:

```bash
docker exec -it solr /bin/bash
```
If the configuration is correct, you should be able to index and query the data in Solr interface.

## Database container & networking

If your database is another container, you may want to create a network and connect both containers to it.

```bash
docker network create solr
docker network connect solr solr
docker network connect solr database-container
```

## Cleanup

To stop and remove Solr:

```bash
docker stop solr && docker rm solr
```

To remove solr network (optional):

```bash
docker network rm solr -f
```