#!/bin/bash
ROOTCA_NAME=root.1.nasa
OPENSSL_CNF=openssl.cnf
PASSWORD="ownca"
ROOTCA_SUBJ="/C=TW/ST=Taiwan/O=nasa/OU=1/CN=ldapprovider.1.nasa/emailAddress=cwang.cs10@nycu.edu.tw"
ROOTCA_QUICK_DIR=${HOME}/ownca
ROOTCA_QUICK_KEY=${ROOTCA_QUICK_DIR}/${ROOTCA_NAME}.key
ROOTCA_QUICK_REQ=${ROOTCA_QUICK_DIR}/${ROOTCA_NAME}.req
ROOTCA_QUICK_CERT=${ROOTCA_QUICK_DIR}/${ROOTCA_NAME}.crt

mkdir -p ${ROOTCA_QUICK_DIR}

openssl genrsa -des3 -passout pass:${PASSWORD} -out ${ROOTCA_QUICK_KEY} 2048
openssl req -passin pass:${PASSWORD} -new -key ${ROOTCA_QUICK_KEY} -out ${ROOTCA_QUICK_REQ} -subj ${ROOTCA_SUBJ}
openssl x509 -passin pass:${PASSWORD} -req -days 7305 -sha1 -extfile ${OPENSSL_CNF} -extensions v3_ca -signkey ${ROOTCA_QUICK_KEY} -in ${ROOTCA_QUICK_REQ} -out ${ROOTCA_QUICK_CERT}
