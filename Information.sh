#!/bin/bash
if [ $# -lt 1 ]
then
  echo "[!] Numero de argumento insuficiente!"
  echo "Script para obter informações de um site alvo!"
  echo "Exemplo de uso: ./Dnsreport sitealvo.com lista.txt"
  exit 1
fi
  echo "$ipbase"
  echo "[+] Buscando proprietario."
    proprietario=$(whois $1 | grep "owner:"| cut -d ":" -f 2 )
  echo "[+] Proprietario:$proprietario"

  echo "[+] Tentando enumerar A, AAAA, CNAME, HINFO, MX, NS, PRT, SOA"
   registros=("A" "AAAA" "CNAME" "HINFO" "MX" "NS" "PTR" "SOA")
  echo ""
    for enumerar in ${registros[@]}
    do
      host -t $enumerar $1 | grep -v "has no"
    done
  echo ""
  echo "[+] Realizando um Brute Force de DNS reverso."
  echo ""
    ip=$(host $1 | grep "has address" | cut -d " " -f 4)
    range=$(whois $ip | grep "NetRange:" | tail -n1 | cut -d ":" -f 2)
    ipbase=$(echo $ip | cut -d "." -f1-3)
    inicioRange=$(echo $range | cut -d " " -f8 | cut -d "." -f4)
    finalRange=$(echo $range | cut -d "." -f7)
  echo "[+] IP do alvo: $ip"
  echo "[+] Range de rede: $range"
  echo ""
  echo "[+] Brute Force DNS reverso"
    for index in $(seq $inicioRange $finalRange)
    do
      host $ipbase.$index | grep -v "not found"
    done
  echo ""
  echo "[+] Realizando transferência de zona."
  echo "####################"
  echo ""
    for server in $(host -t ns $1 | cut -d " " -f4)
    do
      host -l $1 $server | grep -v "not found"
  echo ""
    done
  echo "####################"
diretorios=0
arquivos=0
  echo ""
  echo "[+] Descobrindo arquivos."
    for arquivo in $(cat $2)
    do
      resposta=$(curl -s -o /dev/null -w %{http_code} $1/$arquivo)
        if [ $resposta == 200 ]
        then
          echo "Arquivo encontrado: $arquivo"
          let arquivos=arquivos+1
        fi
    done
  echo ""
  echo "[+] Descobrindo diretorios"
  echo ""
    for diretorio in $(cat $2)
    do
      resposta=$(curl -s -o /dev/null -w %{http_code} $1/$diretorio/)
      if [ $resposta == "200" ]
      then
        echo "Diretorio encontrado: $diretorio"
        let diretorios=diretorios+1
      fi
    done
      if [ $diretorios == 0 ]
      then echo "[-] Nenhum diretorio encontrado"
      fi
      if [ $arquivos == 0 ]
      then
        echo "Nenhum arquivo encontrado"
      fi
