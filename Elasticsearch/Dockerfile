FROM      ubuntu:14.04
MAINTAINER Alok Upadhyay <alokin.ntl@gmail.com>


# Install Java8

RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && apt-get update && apt-get -y install software-properties-common python-software-properties && add-apt-repository -y ppa:webupd8team/java && apt-get update && apt-get -y install oracle-java8-installer && apt-get -y install wget vim 

# Install Elasticsearch

RUN wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -  && echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-5.x.list && apt-get install apt-transport-https && apt-get update && apt-get -y install elasticsearch

COPY elasticsearch.yml /etc/elasticsearch/elasticsearch.yml

#COPY elasticsearch /etc/init.d/elasticsearch

#Install Kibana

RUN apt-get -y install kibana

COPY kibana.yml /etc/kibana/kibana.yml

#Install Nginx

RUN apt-get -y install nginx apache2-utils 

COPY default /etc/nginx/sites-available/default

COPY htpasswd.users /etc/nginx/htpasswd.users

CMD service elasticsearch restart && service kibana restart && nginx -c /etc/nginx/nginx.conf -g 'daemon off;'
