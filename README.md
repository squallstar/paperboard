# Paperboard

## Architecture

Paperboard runs **ruby 2.1.0** with **rails 4**.


### Database

On development, it will use **sqlite**.
On Heroku production **Postgre** will be used, while on Squallstar production **MySQL** server will be used.


## Configuration

Copy ``.env.example`` to ``.env`` and replace with real environment variables.

    $ bundle install

Then, setup the DB:

    $ rake db:schema:load && rake db:seed


## Subscriptions

To load the plans from **Paymill**, run this task:

    $ bundle exec rake paymill:import_plans

Note: plans are automatically imported when you run ``db:seed``.


## Tests

To run the tests:

    $ rake test


## Deployment

### 1. Heroku staging

    $ git remote add heroku git@heroku.com:paperboard.git
    $ git push heroku master


### 2. Squallstar staging

    $ cap deploy staging