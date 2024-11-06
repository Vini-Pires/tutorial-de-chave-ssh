# Comando whoami retorna o nome do usuario e preciso dele para deternimar os caminhos de forma automatica
RegAlun=$(whoami)
homePessoal=/media/$RegAlun/home
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

echo "Configurações copiadas com sucesso"
