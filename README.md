# Paperboard

## Architecture

Paperboard runs **ruby 2.0** with **rails 4**.

### Database

On development, it will use **sqlite**.
On Heroku production **Postgre** will be used, while on Squallstar production **MySQL** server will be used.

## Configuration

    $ brew install mysql
    $ bundle install

Then, setup the DB:

    $ rake db:schema:load && rake db:seed


## Tests

To run the tests:

    $ rake test


## Deployment

### 1. Heroku staging

    $ git remote add heroku git@heroku.com:paperboard.git
    $ git push heroku master

### 2. Squallstar production

Connect with ssh to the server, then navigate to **/home/source/paperboard** and run the following commands:

    $ git pull
    $ rake db:migrate
    $ rake assets:precompile
    $ sudo webrestart
