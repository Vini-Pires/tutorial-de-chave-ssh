# Coleta o RA do usuario
read -p "Informe os numeros do seu RA: " RegAlun

# Verifica se o RA esta digitado corretamente
if [ ! -d $homePessoal ] ; then
  echo "==========================================="
  echo "RA incorreto, verifique seu RA e tente novamente"
  echo "Registro de Aluno: $RA ?"
  echo "==========================================="
  return 1
fi

homePessoal=/media/a$RegAlun/home
dirComAsChaves=$homePessoal/.ssh
dirSSH=~/.ssh

# Caso não haja uma pasta .ssh no diretorio remoto ira criar uma
if [ ! -d $dirComAsChaves ] ; then
  mkdir $dirComAsChaves
fi

# Verifica se ha chaves sendo armazenadas na sua .ssh remota
if [ -z "$(ls $dirComAsChaves)"] ; then
  echo "Não ha chaves armazenadas em $dirComAsChaves"
  echo "Crie uma chave com o comando ssh-keygen"
  return 1
fi

# Caso não haja uma pasta .ssh na home do linux ira criar uma
if [ ! -d $dirSSH ] ; then  
  mkdir $dirSSH
fi

# Caso o diretorio do linux .ssh não esteja vazio alterar permições para que a copia de arquivos aconteça sem problemas
if [ ! -z "$(ls -A $dirSSH)"] ; then
  chmod 664 $dirSSH
fi

# Copia as chaves da sua .ssh remota para a .ssh do linux
cp $dirComAsChaves/* -t $dirSSH
# Altera as permissões de todos os arquivos dentro da .ssh do linux para que somente quem criou possa visualizar
chmod 600 $dirSSH/*
# Altera as permissões das chaves publicas para q sejam visiveis a todos os usuarios
chmod 664 $dirSSH/*.pub
echo "Chaves copiadas com sucesso para $dirSSH"