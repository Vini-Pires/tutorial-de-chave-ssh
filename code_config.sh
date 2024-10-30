read -p "Informe seu RA: " RA
# $homePessoal = /media/a$RA/home

if [ ! -d /media/a$RA/home ] ; then
  echo
  echo "====================================="
  echo "RA incorreto, verifique seu RA e execute novamente o script"
  echo "RA informado: $RA"
  echo "====================================="
  echo
  return 1
fi

if [ ! -d $homePessoal/.vscode ] ; then
  echo "Pasta .vscode não encontrada no seu computador"
  return 1
fi

# cp $homePessoal/.vscode/settings.json -t ~/.vscode