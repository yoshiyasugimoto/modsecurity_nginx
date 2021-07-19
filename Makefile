start:
	docker-compose up -d && docker-compose exec modsecurity /bin/bash -c "tail -f /var/log/modsec_audit.log | jq"
tail:	tail -f ./modsecurity/log/modsec_audit.log | jq
build:
	docker-compose up --build
exec:
	docker-compose exec modsecurity /bin/bash -c "tail -f /var/log/modsec_audit.log | jq"
clean:
	docker-compose down -v
# http://127.0.0.1/index.html?testparam=test
# http://127.0.0.1/index.html