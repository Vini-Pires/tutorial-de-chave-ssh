# ------------------------------------------------------------------------------
helpFunction() {
  echo "*********************************************************************************"
  echo "Usos: $0 -r RegistroAluno"
  echo -e "\t-r Insira o seu RA"
  echo -e "\t-k OPCIONAL -> Nome da chave"
  echo "*********************************************************************************"
}

while getopts "r:k:" opt;
  do
    case $opt in
      r ) RA=$OPTARG ;;
      k ) keyname=$OPTARG ;;
      \? ) 
        helpFunction 
        exit 1  ;; # Imprima helpFunction no caso de algum argumento invalido
    esac
  done

if [ -z "$RA" ]
  then
    echo "#####################################################"
    echo "Informe seu RA na execução do script com a flag -r";
    echo "#####################################################"
    echo "Exemplo: ./script.sh -r 111111"
    helpFunction
    exit 1
fi



# ------------------------------------------------------------------------------
# É aqui q se encontra a pasta home em q seus arquivos n serão excluidos apos o desligamento da maquina
homePersonalSSH=/media/a$RA/home/.ssh

# ------------------------------------------------------------------------------
# Verifica se o RA esta digitado corretamente
if [ ! -d $homePersonalSSH ]
  then
    echo ""
    echo "RA incorreto, verifique seu RA e tente novamente"
    echo ""
fi

# ------------------------------------------------------------------------------
# Verifica se ha uma pasta .ssh na home pessoal para armazenar as chaves
if [ ! -d $homePersonalSSH ];
  # caso não exista ira criar uma pasta e uma chave
  then 
    mkdir $homePersonalSSH
    echo "Como não havia uma pasta para armazenar suas chaves no diretorio Home, tomei a liberdade de criar uma para vc"
    echo "Criado um diretorio .ssh no $homePersonalSSH"
fi
# ------------------------------------------------------------------------------
# Caso ja haja uma pasta .ssh verifica se ela não esta vazia
# Caso esteja vazia cria uma chave ssh padrão ed25519 e
# Armazena-a no diretorio da home pessoal
if [ -z "$(ls -A $homePersonalSSH)"]
  then
    echo "$homePersonalSSH : esta vazio"
    echo "Digite o tipo de chave que sera criada (default: ed25519): "
    read typeKey
    if [ -z $typeKey ] then typeKey=ed25519 fi
    if [ -z "$keyname" ]
      then
        keyname=id_$typeKey
    fi
    ssh-keygen -t $typeKey -f $homePersonalSSH/$keyname -C $RA
    echo "Nova chave $keyname criada com sucesso"
fi

# ------------------------------------------------------------------------------
# Verifica se ha uma pasta .ssh no diretorio home da maquina atual
if [ ! -d ~/.ssh ]
  # Caso não haja ira criar esse diretorio
  then
    mkdir ~/.ssh
    echo "Criado pasta ssh na home do linux "
fi

# ------------------------------------------------------------------------------
# Se uma chave ja existe no diretorio .ssh pessoal copie ela pro diretorio do linux
# Alterando suas permisões para que somente o usuario ativo possa ler a chave
if [ $homePersonalSSH ]
  then
    if [ ! -z "$(ls -A ~/.ssh)" ] 
      then chmod 664 ~/.ssh/*
    fi
    cp $homePersonalSSH/* -t ~/.ssh/
    chmod 400 ~/.ssh/*
    chmod 664 ~/.ssh/*.pub
    echo "Chaves copiadas para ~/.ssh com sucesso"
fi
# ------------------------------------------------------------------------------
