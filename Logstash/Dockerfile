FROM      ubuntu:14.04
MAINTAINER Alok Upadhyay <alokin.ntl@gmail.com>


# Install Java8

RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && apt-get update && apt-get -y install software-properties-common python-software-properties && add-apt-repository -y ppa:webupd8team/java && apt-get update && apt-get -y install oracle-java8-installer && apt-get -y install wget vim

# Install Logstash

RUN wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add - && apt-get install apt-transport-https && echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-5.x.list && sudo apt-get update &&  apt-get -y install logstash

COPY 02-beats-input.conf /etc/logstash/conf.d/02-beats-input.conf
COPY 10-syslog-filter.conf /etc/logstash/conf.d/10-syslog-filter.conf
COPY 30-elasticsearch-output.conf /etc/logstash/conf.d/30-elasticsearch-output.conf

CMD /usr/share/logstash/bin/logstash -f /etc/logstash/conf.d/02-beats-input.conf
