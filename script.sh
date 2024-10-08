helpFunction() {
  echo "Usos: $0 -R RegistroAluno -k NomeChave"
  echo -e "\t-R insira o seu RA"
  echo -e "\t-k insira o nome da chave que deseja manipular esteja certo sobre seu nome"
}

while getopts "R:k:" opt
  do
    case "$opt" in
      R ) RA = "$OPTARG" ;;
      K ) keyname = "$OPTARG" ;;
      ? ) helpFunction ;; # Imprima helpFunction no caso de algum argumento invalido
    esac
  done

if [ -z "$RA" ] || [ -z "$keyname" ];
  then
    echo "Todos ou um dos argumentos estão vazios";
    helpFunction
fi

homePersonalSSH = /media/a$RA/home/.ssh

# verifica se ha uma pasta para armazenar as chaves
if [ !$homePersonalSSH/ ];
  # caso não exista ira criar uma pasta
  then 
    mkdir $homePersonalSSH/
    echo "Criado um diretorio .ssh no $homePersonalSSH"
fi

# Verifica se ha chaves sendo armazenadas, caso não haja ira criar uma
if [ -z "(ls -A $homePersonalSSH)" ]
  then
    ssh-keygen -t ed25519 -f $homePersonalSSH/$keyname -C $RA
    echo "Chave $keyname criada com sucesso"
    

# Se a chave ja existe no diretorio .ssh pessoal copie ela pro diretorio do linux
if [ $homePersonalSSH/$keyname ]
  then
    cp -r $homePersonalSSH/ -t ~/.ssh/
    chmod 400 ~/.ssh/$keyname
