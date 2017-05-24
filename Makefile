run-es:
	docker rm -f elasticsearch || true
	docker run -d --name elasticsearch -e "bootstrap_memory_lock=true" --ulimit memlock=-1:-1 -e ES_JAVA_OPTS="-Xms1g -Xmx1g" -e "http.host=0.0.0.0" -e "transport.host=127.0.0.1" docker.elastic.co/elasticsearch/elasticsearch:5.4.0

run-kibana:
	docker rm -f kibana || true
	docker run -d --name kibana --link elasticsearch:elasticsearch -e ELASTICSEARCH_USERNAME='elastic' -e ELASTICSEARCH_PASSWORD='changeme' -p 8081:5601 docker.elastic.co/kibana/kibana:5.4.0

build-logstash:
	docker build -t opstree/logstash -f Logstash/Dockerfile Logstash

run-logstash:
	docker rm -f logstash || true
	docker run --name logstash -p 8089:5044 --link elasticsearch:elasticsearch -d opstree/logstash

build-shipper:
	docker build -t opstree/shipper -f shipper/Dockerfile shipper

run-shipper:
	docker rm -f shipper || true
	docker run --name shipper  --link logstash:logstash -d opstree/shipper

make run-elk:
	make build-logstash
	make build-shipper
	make run-es
	make run-logstash
	make run-kibana
	make run-shipper
