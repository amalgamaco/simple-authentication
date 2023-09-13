# SimpleAuthentication

SimpleAuthentication is a gem that handles the facilitation and abstraction of the logic involved in authorization processes (sign_up, login, reset password, etc...).

# Installation
To add this gem to your project simply add the next line to your project's Gemfile:

```ruby
gem 'simple_authentication', github: 'amalgamaco/simple-authentication'
```

## How to Use this Gem
To use this gem, you just need to understand how its different parts work that you want to use. I will describe them below:

### Controller
The gem provides a controller class called `SimpleAuth` that calls the corresponding interactors for each functionality. The idea is to create controllers for our models that inherit from this `SimpleAuth` class and implement the `user_klass_name` and `user_attributes` methods. As their names suggest, we will define the model name as a string in `user_klass_name` if we have a model like `User`:

```ruby
def user_klass_name
  'user'
end
```

And for `user_attributes`, we will define the `params` that we want to allow or require to create a new instance of the model.

### SignUp
For signing up, we have a method in the controller called `sign_up`, which is responsible for calling this interactor, passing the `user_klass_name` and `user_attributes` that we defined in the controller. At the time of writing this README, the `signUp` interactor simply creates an instance of the model specified with the attributes passed to it; it doesn't do anything more for now.

### Recover Password
Now, to recover the password of our users, we have two endpoints. The first one, `forgot_password`, is responsible for using the user's email that we pass to it to send recovery instructions to the user, assuming that we have defined a method for the user class called `send_reset_password_instructions` that handles the email logic. The second endpoint, `reset_password`, takes care of setting the new password for our user, given the `user_klass_name` and `reset_password_params`, which will vary depending on how we reset a user's password. It assumes that our user model knows how to reset a password according to a token with a class method called `reset_password_by_token`.

The Devise gem includes the necessary methods to use this endpoint correctly, so we recommend using it to keep things "simple."

## Contribute
To contribute to this amazing gem, you contribute in the same way as in the projects you work on: pick up an issue, move it to "doing," push it, and send the MR to the people responsible for reviewing MRs in standardization.

### Development Setup
To set up for development, you need to do a bit more than what we usually do in Rails projects. We need to have sqlite3 installed (because that's what we use to run tests in the sample app). You should run the following commands:

```sh
gem install json
bundle install
cd spec/dummy
RAILS_ENV=test bin/rails db:create db:migrate
cd ../../
```