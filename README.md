# Instalación del entorno de desarrollo
Guía para sistemas Ubuntu 14.04.02 (sobre la versión 15 hay algunos problemas con MongoDB)

## Instalación CURL y RVM

``` 
sudo apt-get install curl
command curl -sSL https://rvm.io/mpapis.asc | gpg --import -
\curl -sSL https://get.rvm.io | bash -s stable --rails
```

Agregar en bashrc, pero esto es temporal, si cerrais la terminal habria que volver a ejecutar este commando despues de haber instalado todo

```
source ~/.rvm/scripts/rvm
rvm install ruby
gem install rails
```

### Añadiendo RVM al path permanentemente
 Primero abrimos el editor con `gedit ~/.bashrc` y agregamos las siguientes lineas al final del documento `bashrc`
```
# This loads RVM into a shell session.
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
```

###Probamos que se haya instalado correctamente rails
Creamos una nueva aplicación con `rails new nombre_aplicación`

Aunque en principio no debe hacer falta, lo siguiente es lo que se encarga de instalar las gemas que tenemos definidas para la app, es decir, se encarga de descargar las librerias necesarias para nuestra aplicacion.

`bundle install`

## Instalar GIT
Usamos `sudo apt-get install git` y luego configuramos (con las comillas)
```
git config --global user.name "tu_nombre"
git config --global user.email "tu@correo.com"
```
La dirección de correo tiene que ser alguna que tenga permisos con Github (no necesariamente la principal).
Ahora generamos una clave ssh para poder autorizar la conexión con Github

```
ssh-keygen -t rsa -C "tu@correo.com"
cat ~/.ssh/id_rsa.pub
```
Copiamos, con cuidado de añadir espacios, la clave que nos ha aparecido con el comando cat y la agregamos a Github. Para ello, en la pagina de Github vamos a `Settings -> SSH Keys -> Add SSH key`. Con esto ya le hemos dado permiso a git para que acceda a Github y podemos ya clonar el repositorio.

```
git clone git@github.com:Oscarvas/mineria.git
```

### Algunos comandos basicos para empezar con Git
```
git status
git pull
git add .
git commmit -m 'mensaje explicativo de los cambios'
git push origin master
```

* **status**: Nos indica si existen diferencias entre el repo local y Github.
* **pull**  : Cargamos en local la última versión existente en Github.
* **add**   : El punto es importante. Con esto preparamos todos los cambios locales sobre una sola transacción que luego será subida con commit (el punto indica que agregue todos los cambios, como en `SQL` el * cuando se hace `select * from...`).
* **commit**: Comprometemos la transacción para ser subida al repo. Tened en cuenta que todavía no se han subido los cambios.
* **push**  : En este punto es cuando realmente le decimos a git que suba todos los cambios a Github. Además indicamos que lo suba en la rama principal del repo.

## Instalando Sublime Text
Esto ya es gusto de cada quien, pero yo os lo propongo porque la verdadd es que me resulta bastante cómodo éste editor de textos.
```
sudo add-apt-repository ppa:webupd8team/sublime-text-3
sudo apt-get update
sudo apt-get install sublime-text-installer
```

## Instalando MongoDB
```
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
sudo apt-get update
sudo apt-get install -y mongodb-org
```
Ahora instalamos el driver de conexión de rails con mongodb: `gem install mongoid`
