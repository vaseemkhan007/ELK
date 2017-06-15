FROM      docker.elastic.co/elasticsearch/elasticsearch:5.4.0

ENV bootstrap_memory_lock true
ENV ES_JAVA_OPTS "-Xms1g -Xmx2g"
ENV http.host "0.0.0.0"
ENV transport.host 127.0.0.1

#Plugins are already installed
#RUN bin/elasticsearch-plugin install ingest-geoip
#RUN bin/elasticsearch-plugin install ingest-user-agent
