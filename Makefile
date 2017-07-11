build-es:
	docker build -t opstree/es -f elasticsearch/Dockerfile elasticsearch

run-es:
	docker rm -f elasticsearch || true
	docker run -d --name elasticsearch --ulimit memlock=-1:-1 opstree/es

run-kibana:
	docker rm -f kibana || true
	docker run -d --name kibana --link elasticsearch:elasticsearch -e ELASTICSEARCH_USERNAME='elastic' -e ELASTICSEARCH_PASSWORD='changeme' -p 8081:5601 docker.elastic.co/kibana/kibana:5.4.0

build-logstash:
	docker build -t opstree/logstash -f Logstash/Dockerfile Logstash

run-logstash:
	docker rm -f logstash || true
	docker run --name logstash --link elasticsearch:elasticsearch -d opstree/logstash

build-shipper:
	docker build -t opstree/shipper -f shipper/Dockerfile shipper

run-shipper:
	docker rm -f shipper || true
	docker run --name shipper  --link logstash:logstash --link elasticsearch:elasticsearch -d opstree/shipper

generate-service-logs:
	docker cp shipper/services.log shipper:/tmp/services.log
	docker exec -it shipper bash -c "./generateLog.sh 10 services.log"

generate-apache-logs:
	docker cp shipper/apache.log shipper:/tmp/apahe.log
	docker exec -it shipper bash -c "./generateLog.sh 10 apache.log"

generate-nginx-logs:
	docker cp shipper/nginx.log shipper:/tmp/nginx.log
	docker exec -it shipper bash -c "./generateLog.sh 100 nginx.log"

generate-uwsgi-logs:
	docker cp shipper/uwsgi.log shipper:/tmp/uwsgi.log
	docker exec -it shipper bash -c "./generateLog.sh 10 uwsgi.log"

generate-auth-logs:
	docker cp shipper/auth.log shipper:/tmp/auth.log
	docker exec -it shipper bash -c "./dynamicGenerateLog.sh 10000 auth.log"

generate-server1-logs:
	docker cp shipper/server1.log shipper:/tmp/server1.log
	docker exec -it shipper bash -c "./generateLog.sh 100 server1.log"

generate-core-logs:
	docker cp shipper/core.log shipper:/tmp/core.log
	docker exec -it shipper bash -c "./generateLog.sh 100 core.log"

make run-elk:
	make build-logstash
	make build-shipper
	make run-es
	make run-logstash
	make run-kibana
	make run-shipper
