# Coleta o RA do usuario
read -p "Informe os numeros do seu RA: " RegAlun

# Verifica se o RA esta correto
if [ ! -d $homePessoal ] ; then
  echo
  echo "====================================="
  echo "RA incorreto, verifique seu RA e execute novamente o script"
  echo "RA informado: $RegAlun"
  echo "====================================="
  echo
  return 1
fi

homePessoal=/media/a$RegAlun/home
vscode=$homePessoal/.vscode
settingsVscode=~/.config/Code/User

# Verifica se ha uma pasta .vscode na home remota
if [ ! -d $vscode ] ; then
  echo "Pasta .vscode não encontrada no seu computador "
  return 1
fi

# Copia os arquivos da pasta .vscode remota para as configurações do vscode
cp $vscode/settings* -t $settingsVscode
cp $vscode/key* -t $settingsVscode
mkdir $vscode/aux
mv $vscode/ext* -t $vscode/aux
mv $vscode/copia.json.bkp $vscode/extensions.json
mv $vscode/ext* -t ~/.vscode/ext*
mv $vscode/aux/ext* -t $vscode
rmdir $vscode/aux 
