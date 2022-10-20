# SimpleAuthentication

SimpleAuthentication es una gema que se encarga de facilitar y abstraer la logica involucrada en los procesos de autorizacion ( sign_up, login ,reset password,etc...). Sigue en desarrollo, pero al momento de escribir este README , la funcionalidad de el sign_up esta disponible

## Como usar esta gema
Para usar esta gema, simplemente hay que saber como funcionan las distintas partes de la misma, que queramos usar. Las voy a describir a continuacion:

### Controller
La gema provee una clase controller llamada `SimpleAuth` que llama a los interactors correspondientes a cada funcionalidad. La idea es crear controllers para nuestros modelos que hereden esta clase SimpleAuth y que implementen los metodos `user_klass_name` y `user_attributes` donde como lo indican sus nombres, vamos a definir el nombre del modelo como un string por si tuviesemos el modelo `User`:

```rb
def user_klass_name
	'user'
end
```
Y para `user_attributes` vamos a definir los `params` que permitir o requerir para crear una nueva instancia del modelo.

### SignUp
Para el signUp tenemos un metodo del controller `sign_up` que se encarga de llamar a este interactor pasandole la user_klass_name y los user_attributes que definimos en el controller.
Al momento de escribir este README, el interactor `signUp` simplemente crea una instancia del modelo que se le indica con los atributos que se le pasan, no hace nada mas por ahora.

### Recover password
Ahora, para recuperar la password de nuestros `users` tenemos dos endpoints , el primero, `forgot_password` que se encarga de usar el mail del usuario que le pasamos para mandar las intrucciones de recuperacion al mismo, suponiendo que tenemos definido algun metodo para la clase usuario llamado `send_reset_password_instructions` que se encargue de la logica de los mails. El segundo endpoint `reset_password` se encarga de ,dado el `user_klass_name` y los `reset_password_params`, que van a variar dependiendo de como reseteemos la pass de un usuario, se encarga de setear la nueva password de nuestro usuario. Al igual que con `forgot_password`, `reset_password` asume que nuestro modelo de usuario sabe resetear una password acorde a un token con un metodo de clase llamado `reset_password_by_token`.

La gema devise incluye los metodos necesarios para utilizar este endpoint correctamente, por lo que recomendamos usarla para mantener las cosas "simples".

### Block and Unblock
Para blockear y desbloquear tenemos tanto interactors como controllers, llamados `block_user` y `unblock_user` respectivamente. Estos reciben el `current_user` (el usuario conectado) y dos parametros: `blocked_user_id` y `block_relation_klass_name`. `blocked_user_id` es el id del usuario que queremos bloquear o desbloquear, y `block_relation_klass_name` es el nombre de nuestro modelo de block que relaciona a los users. 

## Contribuir
Para contribuir en esta asombrosa gema, se contribuye de la misma forma que en los proyectos en los que trabajamos, agarramos un issue, lo pasamos a doing, lo pusheamos y mandamos el MR a las personas encargadas de revisar MR's en estandarizacion.

### Set-up para desarrollo
Para hacer el setup hay que hacer algo mas, ademas de lo que solemos hacer en proyectos de rails.
Necesitamos tener sqlite3 instalado (porque eso es lo que usamos para correr los tests en la app de prueba).
Tenemos que correr:
```sh
     gem install json
     bundle install
     cd spec/dummy && bundle exec rake db:create db:migrate db:seed
     RAILS_ENV=test bin/rails db:create db:migrate
     cd ../../
```
### A quien mandar mr's
Dentro del grupo de estandarizacion hay responsables de cada foco que se encargan de revisar los mr's, averiguar quienes son en el momento de contribuir.
