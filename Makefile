run-es:
	docker rm -f elasticsearch || true
	docker run --name elasticsearch -e "bootstrap_memory_lock=true" --ulimit memlock=-1:-1 -e ES_JAVA_OPTS="-Xms1g -Xmx1g" -e "http.host=0.0.0.0" -e "transport.host=127.0.0.1" docker.elastic.co/elasticsearch/elasticsearch:5.4.0

run-kibana:
	docker rm -f kibana || true
	docker run --name kibana --link elasticsearch:elasticsearch -e ELASTICSEARCH_USERNAME='elastic' -e ELASTICSEARCH_PASSWORD='changeme' -p 8081:5601 -d docker.elastic.co/kibana/kibana:5.4.0

build-proxy:
	docker rm -f proxy || true
	docker build -t opstree/elk -f proxy/Dockerfile proxy

run-proxy:
	docker run --name proxy --link kibana:kibana -p 8080:80 -it opstree/elk

build-logstash:
	docker build -t opstree/logstash -f Logstash/Dockerfile Logstash

run-logstash:
	docker rm -f logstash || true
	docker run --name logstash  --link elasticsearch:elasticsearch -it opstree/logstash
