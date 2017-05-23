build-es:
	docker build -t opstree/es -f Elasticsearch/Dockerfile Elasticsearch

run-es:
	docker rm -f elasticsearch || true
	docker run --name elasticsearch -p 8080:80 -it opstree/es

build-logstash:
	docker build -t opstree/logstash -f Logstash/Dockerfile Logstash

run-logstash:
	docker rm -f logstash || true
	docker run --name logstash  --link elasticsearch:elasticsearch -it opstree/logstash
