VAGRANT SHELL - VIRTUAL BOX
=============

Usando vagrant e virtual box para configurar um ambiente de desenvolvimento (LAMP) de forma simples.

CONFIGURAÇÕES (VagrantFile)
------------
* BOX_NAME       = "nome-do-box"
* BOX_MEMORY     = 512
* BOX_IP         = "192.168.50.XX"
* SYNCED_FOLDER  = "~/Dropbox/jobs/nome-da-pasta/"

MYSQL
------------
* Host: Pode ser acessado pelo IP configurado no box ou localhost
* Usuário Root: root
* Senha Root: mysql

Forma de Uso
------------
* Clonar o repositório para a pasta onde utiliza a maquina virtual
    * $ git clone git@github.com:dindigital/vagrant-shell.git /path/mvs/nome-do-box
* Alterar as configurações no arquivo VagrantFile
* $ vagrant up
* Dentro da pasta compartilhada aparecerá uma nova pasta chamada vhosts, onde poderá criar novos arquivos. 
* Para que a maquina virtual reconheça os arquivos basta usar o **$ vagrant reload** ou reiniciar o apache.
    * $ vagrant ssh 
    * $ sudo service apache restart
    * **OBS: Não é necessário fazer o $ vagrant provision**
