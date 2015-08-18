# docker-lib

### Postgres 9.4
build local image:
```sh
$ docker build -t postgres/amazon98:latest postgres/9.4/
```
run with endpoint script (data inserting):
```sh
$ docker run -t -i postgres/amazon98:latest
```
run directly in bash (without endpoint):
```sh
$ docker run -t -i postgres/amazon98:latest bin/bash
#start postgres service 
$ /etc/init.d/postgresql start
#connect to reviews db with role onyme
psql -h localhost -p 5432 -U onyme -d reviews -W
```
