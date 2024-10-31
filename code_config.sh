read -p "Informe seu RA: " RegAlun
homePessoal=/media/a$RegAlun/home
vscode=$homePessoal/.vscode
settingsVscode=~/.config/Code/User

if [ ! -d $homePessoal ] ; then
  echo
  echo "====================================="
  echo "RA incorreto, verifique seu RA e execute novamente o script"
  echo "RA informado: $RegAlun"
  echo "====================================="
  echo
  return 1
fi

if [ ! -d $vscode ] ; then
  echo "Pasta .vscode não encontrada no seu computador "
  return 1
fi

cp $vscode/settings* -t $settingsVscode
cp $vscode/key* -t $settingsVscode
cp $vscode/ext* -t ~/.vscode/ext*
