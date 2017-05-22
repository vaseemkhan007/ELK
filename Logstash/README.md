# This docker file install logstash server 
	 
You can change your Elasticsearch ip from this file 30-elasticsearch-output.conf 


	output {
  		elasticsearch {
    		hosts => ["<Elasticsearch IP>:9200"]
    		sniffing => true
   		manage_template => false
    		index => "%{[@metadata][beat]}-%{+YYYY.MM.dd}"
    		document_type => "%{[@metadata][type]}"
  	}
	}

