start:
	docker-compose up -d && docker-compose exec modsecurity /bin/bash -c "tail -f /var/log/modsec_audit.log | jq"
tail:	tail -f ./modsecurity/log/modsec_audit.log | jq
build:
	docker-compose up -d --build && docker-compose exec modsecurity /bin/bash -c "tail -f /var/log/modsec_audit.log | jq"
exec:
	docker-compose exec modsecurity /bin/bash
basic auth:
	docker-compose exec modsecurity /bin/bash -c "htpasswd -c /etc/nginx/htpasswd username"
clean:
	docker-compose down -v

# waf log　特定のパラメータによる異常検知
# http://127.0.0.1/index.html?testparam=test
# http://127.0.0.1/index.html

# basic認証
# http://127.0.0.1/private
# make basic auth
# input password and Re-type input password