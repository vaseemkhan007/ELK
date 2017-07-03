FROM prima/filebeat:5
COPY filebeat.yml /filebeat.yml
#COPY filebeat.yml /filebeat.template.json
#COPY filebeat.yml /etc/filebeat/filebeat.yml
COPY generateLog.sh /
COPY dynamicGenerateLog.sh /
RUN chmod go-w /filebeat.yml
