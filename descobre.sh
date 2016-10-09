#!/bin/bash
#Script para encontrar diretorios e arquivos de um site utilizando uma wordlist.
diretorios=0
arquivos=0
if [ $1 == "" ]
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
let diretorios=$diretorios+1
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
	echo "Arquivo encontrado: $palavra"
let arquivos=$arquivos+1
fi
done
if [ $diretorios == 0 ]
then
echo "Não foram encontrado diretorios"
else
echo "Diretorios encontrado: $diretorios"
fi
if [ $arquivos == 0 ]
then
echo "Não foram encontrados arquivos"
else
echo "Arquivos encontrado: $arquivos"
fi
fi
