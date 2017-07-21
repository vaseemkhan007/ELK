FROM docker.elastic.co/logstash/logstash:5.4.0
RUN rm -f /usr/share/logstash/pipeline/logstash.conf
COPY logstash.yml /usr/share/logstash/config/logstash.yml
#ADD pipeline/ /usr/share/logstash/pipeline/
RUN mkdir /usr/share/logstash/plugins
COPY patterns/* /usr/share/logstash/vendor/bundle/jruby/1.9/gems/logstash-patterns-core-4.0.2/patterns/
ADD config/ /usr/share/logstash/pipeline/
