#!/bin/bash

i=0
path=`pwd` 
while [ $i -ne 9 ] ; do
  # clear
  echo "Bem vindo as menu de configurações do git"
  echo "1 - Inicializar git"
  echo "2 - Configurar User"
  echo "3 - Clonar repositorio"
  echo "# - Sair"
  read -p "Escolha uma das opções: " res
  case $res in
    1 ) 
      echo "Voce esta aqui: ($path)"
      read -p "Informe a localização do projeto: " initial
      
      if [ ! -d initial ] ; then
        echo "Localização inexistente"
        read -p "Deseja criar? (y/N)" yes
        case $yes in
          [Yy] )
            mkdir $initial 
            if [ $? -ne 0 ] ; then
              echo "Erro ao criar a pasta, verifique se as demais partes do caminho existem"
              echo $initial
              echo "Voltando ao menu..."
              continue
            fi
            echo "Pasta criada com sucesso"
          ;;

          * )
            echo "Retornando ao menu..." 
            true
          ;;
        esac
      fi
      
      cd $initial
      git init
      git branch -M main
      
      read -p "Informe o SSH do projeto" github
      git remote add origin $github

    ;;
    2 ) :
      read -p 
    ;;
    3 ) : ;;
    * ) : return 0 ;;

  esac 

done


# if [ ! -d ./.git ] ; then
  
#   read -p "Voce tem ctz que deseja criar um repositorio aqui [$path]? (y/N): " res
#   # echo $res
#   case $res in
#     [Yy] ) : 
#       git init
#       git branch -M main
      
#       read -p "Repositorio Github remoto: " online
#       git remote add origin $online
      
#       sh git_user.sh

#       # read -p "Nome da chave ssh: " ssh
#       # git config core.sshCommand "ssh -o ~/.ssh/$ssh -i IdentitiesOnly=yes"
#       echo "Repositorio local criado com sucesso"
#       ;;
    
#     * ) : return 1 ;;
#   esac

#   return 1
# fi

# echo "Já ha uma pasta .git nesse diretorio"