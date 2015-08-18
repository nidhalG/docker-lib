FROM ubuntu:trusty
MAINTAINER dev@onyme.com


## add postgres group/user 
RUN groupadd -r postgres && useradd -r -g -p postgres postgres postgres

# verify PostgreSQL packages: PGP key must be the same as https://www.postgresql.org/media/keys/ACCC4CF8.asc
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8

# add PostgreSQL's repository for recent stable release
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main 9.4" > /etc/apt/sources.list.d/pgdg.list

# update the Ubuntu and PostgreSQL repository indexes && install
RUN apt-get update
RUN apt-get -y -q install python-software-properties software-properties-common
RUN apt-get -y -q install postgresql-plpython-9.4 postgresql-9.4 postgresql-client-9.4 postgresql-contrib-9.4

## update $Path
ENV PATH /usr/lib/postgresql/9.4/bin:$PATH

# set Locale
RUN update-locale "en_US.UTF-8"

# commands in container will be excuted by postgres user
USER postgres

# run postgres service, creta eonyme role and reviews database
RUN    /etc/init.d/postgresql start &&\
    psql --command "CREATE USER onyme WITH SUPERUSER PASSWORD 'admin';" &&\
    createdb -O onyme reviews;

# trust local/host connections with onyme role 
#NB: pourtant, je n'arrive pas à annuler la config par défaut (local all all md5)
RUN echo "host    reviews        onyme        0.0.0.0/0            trust" >> /etc/postgresql/9.4/main/pg_hba.conf
RUN echo "local    reviews        onyme                                trust" >> /etc/postgresql/9.4/main/pg_hba.conf
RUN echo "listen_addresses='*'" >> /etc/postgresql/9.4/main/postgresql.conf


## add postgres volume
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

## mount sql script for reviews inserting
ADD amazon_review1998.sql /amazon_review1998.sql
COPY docker-entrypoint.sh /

# entrypoint script to excute at container startup  
ENTRYPOINT ["/docker-entrypoint.sh"]


# Expose PostgreSQL port
EXPOSE 5432

#CMD ["/usr/lib/postgresql/9.4/bin/postgres", "-D", "/var/lib/postgresql/9.4/main", "-c", "config_file=/etc/postgresql/9.4/main/postgresql.conf"]
# parameters to the endpoint shell script
CMD ["postgres", "/amazon_review1998.sql"]



