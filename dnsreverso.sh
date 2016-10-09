#!/bin/bash
#Script DNS Reverso
#Informe o IP fixo e o range de IP

if [ "$#" -lt 3 ]
then
echo "Script DNS reverso"
echo "Exemplo de uso: $0 ip fixo + bloco de ip inicial + bloco de ip final"
else
for ip in $(seq $2 $3);
do
host $1.$ip
done
fi
