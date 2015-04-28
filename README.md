# mineria
Data Mining Project


``` 
command curl -sSL https://rvm.io/mpapis.asc | gpg --import -

\curl -sSL https://get.rvm.io | bash -s stable --rails
```

Agregar en bashrc, pero esto es temporal, si cerrais la terminal habria que volver a ejecutar este commando despues de haber instalado todo
```
source ~/.rvm/scripts/rvm

rvm install ruby

gem install rails
```
##Opcional
```
rvm gemset create prueba

rvm ruby-2.2.0@prueba
```

Necesario para arrancar terminal con el path incluido (abrir este archivo). Esto soluciona el problema de tener que ejecutar el comando que empieza con source ~/… cada vez que se inicia una terminal nueva

` gedit ~/.bashrc `

agregar esto al final del document tal cual aparece aqui

```
# This loads RVM into a shell session.

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
```

Appname lo sustituimos por el nombre de la app que nos venga en gana
` rails new [appname] `

Aunque en principio no debe hacer falta, lo siguiente es lo que se encarga de instalar las gemas que tenemos definidas para la app, es decir, se encarga de descargar las librerias necesarias para nuestra aplicacion.

`bundle install`

Estos son los pasos basicos para tener funcionando lo esencial. Faltaria indicar a rails que la BBDD que queremos usar es mongo y por tanto tendriamos que agregar al archive gemfile que tenemos de la aplicacion la linea correspondiente para incorporar mongoid a la app.
