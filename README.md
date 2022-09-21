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

