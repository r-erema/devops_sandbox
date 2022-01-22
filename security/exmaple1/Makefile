# https://gist.github.com/fntlnz/cf14feb5a46b2eda428e000157447309
# https://docs.microsoft.com/en-us/azure/application-gateway/self-signed-certificates

DOMAIN=twizar.net

CA_CERT_PATH=rootCA.crt
CA_KEY_PATH=rootCA.key

CSR_PATH=${DOMAIN}.csr

CERT_KEY_PATH=${DOMAIN}.key
CERT_PATH=${DOMAIN}.crt

run: generate-CA \
	generate-certificate-key \
	generate-CSR \
	generate-certificate

generate-CA:
	openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 \
		-subj "/C=BY/ST=Minsk Region/L=Minsk/O=${DOMAIN} Office/CN=${DOMAIN}/subjectAltName=DNS.1=${DOMAIN}" \
		-keyout ${CA_KEY_PATH} -out ${CA_CERT_PATH}

generate-certificate-key:
	openssl genrsa -out ${CERT_KEY_PATH} 2048

generate-CSR:
	openssl req -new -key ${CERT_KEY_PATH} \
		-subj "/C=BY/ST=Minsk Region/L=Minsk/O=${DOMAIN} Office/CN=${DOMAIN}/subjectAltName=DNS.1=${DOMAIN}" \
		-out ${CSR_PATH}

generate-certificate:
	printf "subjectAltName=DNS:${DOMAIN}" > tmp-ext-file
	openssl x509 -req -extfile tmp-ext-file -in ${CSR_PATH} -days 365 \
		-CA ${CA_CERT_PATH} \
		-CAkey ${CA_KEY_PATH} \
		-CAcreateserial \
		-out ${CERT_PATH}
	rm tmp-ext-file
