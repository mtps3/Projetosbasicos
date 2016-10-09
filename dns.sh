#!/bin/bash
#Script para fazer pesquisa direta DNS
#Crie sua lista.txt no diretorio do Script

if [ "$1" == "" ]
then
	echo "Script para pesquisa direta DNS"
	echo "Exemplo de uso: $0 www.sitealvo.com.br"
else
for url in $(cat lista.txt)
do
host $url.$1
done | grep "has address"
fi
