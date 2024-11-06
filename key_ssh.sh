# Comando whoami retorna o nome do usuario e preciso dele para deternimar os caminhos de forma automatica
RegAlun=$(whoami)
homePessoal=/media/$RegAlun/home
dirComAsChaves=$homePessoal/.ssh
dirSSH=~/.ssh

# Caso não haja uma pasta .ssh no diretorio remoto ira criar uma
if [ ! -d $dirComAsChaves ] ; then
  mkdir $dirComAsChaves
fi

# Verifica se ha chaves sendo armazenadas na sua .ssh remota
if [ -z "$(ls $dirComAsChaves)"] ; then
  echo
  echo "Não ha chaves armazenadas em $dirComAsChaves"
  echo "Crie uma chave com o comando ssh-keygen"
  echo
  return 1
fi

# Caso não haja uma pasta .ssh na home do linux ira criar uma
if [ ! -d $dirSSH ] ; then  
  mkdir $dirSSH
fi

# Caso o diretorio do linux .ssh não esteja vazio alterar permissões para que a copia de arquivos aconteça sem problemas
if [ -n "$(ls -A $dirSSH)"] ; then
  chmod 664 $dirSSH
fi

chmod 764 $dirSSH
# Copia as chaves da sua .ssh remota para a .ssh do linux
cp $dirComAsChaves/* -t $dirSSH
# Altera as permissões de todos os arquivos dentro da .ssh do linux para que somente quem criou possa visualizar
chmod 600 $dirSSH/*
# Altera as permissões das chaves publicas para q sejam visiveis a todos os usuarios
chmod 664 $dirSSH/*.pub
chmod 664 $dirSSH/know*
echo "Chaves copiadas com sucesso para $dirSSH"
