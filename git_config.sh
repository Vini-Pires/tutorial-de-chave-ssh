if [ ! -d ./.git ] ; then
  path=`pwd`
  read -p "Voce tem ctz que deseja criar um repositorio aqui [$path]? (y/N): " res
  # echo $res
  case $res in
    [Yy] ) : 
      git init
      git branch -M main
      
      read -p "Repositorio Github remoto: " online
      git remote add origin $online
      
      read -p "Nome: " name
      git config user.name $name
      
      read -p "Email: " email
      git config user.email $email

      read -p "Nome da chave ssh: " ssh
      git config core.sshCommand "ssh -o ~/.ssh/$ssh -i IdentitiesOnly=yes"
      echo "Repositorio local criado com sucesso"
      ;;
    
    * ) : return 1 ;;
  esac

  return 1
fi

echo "Já ha uma pasta .git nesse diretorio"