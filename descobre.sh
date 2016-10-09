#!/bin/bash

#Script para encontrar diretorios e arquivos de um site utilizando uma wordlist.
#Crie sua wordlist para o script

if [ $1 == ""]
then
	echo "Script para descobrir diretorios e arquivos de um site"
	echo "exemplo de uso: $0 www.sitealvo.com.br"
else
	echo "##############################"
	echo "Procurando por diretorios"
	echo "##############################"
for palavra in $(cat lista.txt)
do

	resposta=$(curl -s -o /dev/null -w "%{http_code}" $1/$palavra/)
if [ $resposta == 200 ]
then
	echo "diretorio encontrado: $palavra"
fi
done
	echo "##############################"
	echo "Procurando arquivos"
	echo "##############################"
for palavra in $(cat lista.txt)
do
	resposta=$(curl -s -o /dev/null -w "%{http_code}" $1/$palavra)
if [ $resposta == 200 ]
then
	echo "Arquivo encontrado em: $palavra"
fi
done
fi
