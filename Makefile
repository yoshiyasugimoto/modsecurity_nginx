run:
	docker run -it -p 80:80 --name modsecurity nginx:1.19.9 /bin/bash
tail:
	tail -f /var/log/modsec_audit.log | jq
create log:
	mkdir log && touch /log/all_access.log
server start:
	nginx
conf update:
	nginx -s reload
setting modsecurity configure:
	vim /etc/nginx/modsecurity/modsecurity.conf
	# add -> SecAuditLogFormat JSON
	# comment out -> SecAuditLog /var/log/modsec_audit.log
	# add -> SecAuditLog /log/modsec_audit.log
	# chenge -> SecAuditEngine RelevantOnly -> SecAuditEngine on
	# nginx -s reload
build:
	docker-compose up --build
exec:
	docker-compose exec modsecurity /bin/bash -c "nginx -s reload && tail -f /var/log/modsec_audit.log | jq"
clean:
	docker-compose down -v