helpFunction() {
  echo "*****************************************************************************************************************"
  echo "Usos: $0 -r RegistroAluno"
  echo -e "\t-r insira o seu RA"
  echo -e "\t-k nome da chave -> OPCIONAL"
  echo "*****************************************************************************************************************"
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

if [ -z "$keyname" ]
  then
    keyname=id_ed25519
fi

homePersonalSSH=/media/a$RA/home/.ssh

if [ ! -d $homePersonalSSH ]
  then
    echo ""
    echo "R A incorreto, verifique seu RA e tente novamente"
    echo ""
fi

# verifica se ha uma pasta para armazenar as chaves
if [ ! -d $homePersonalSSH ];
  # caso não exista ira criar uma pasta e uma chave
  then 
    mkdir $homePersonalSSH
    ssh-keygen -t ed25519 -f $homePersonalSSH/$keyname -C $RA
    echo "Chave $keyname criada com sucesso"
    echo "Criado um diretorio .ssh no $homePersonalSSH"
fi

if [ ! -d ~/.ssh ]
  then
    mkdir ~/.ssh
    echo "Criado pasta ssh na home do linux "
fi

# Se a chave ja existe no diretorio .ssh pessoal copie ela pro diretorio do linux
if [ $homePersonalSSH ]
  then
    if [ ! -z "$(ls -A ~/.ssh)" ] 
      then chmod 664 ~/.ssh/*
    fi
    cp $homePersonalSSH/* -t ~/.ssh/
    chmod 400 ~/.ssh/*
    chmod 664 ~/.ssh/*.pub
fi