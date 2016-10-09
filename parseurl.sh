#Script para resolver dominios de sites

#Nem todos os sites funcionam, sites testados foram:

#uern.br e grandbusiness.com.br

#!/bin/bash
if [ "$1" == "" ]
then
echo "Curso de Pentest Profissional"
echo "Parsing em sites"
echo "Exemplo de uso: $0 www.sitealvo.com"
else
wget $1
cat index.html | grep href | cut -d"/" -f 3 | grep -v ">"| grep -v "href" | grep -v "rel" | cut -d '"' -f 1 > lista.txt| sort -u
for url in $(cat lista.txt)
do
host $url
done | grep "has address"

rm index.html
fi

