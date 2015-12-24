# Kwipper

Kwipper is the reference example app for the Kwipper Programming Challenge. See more information on the live app [demo](#soon).

## Installation

    $ git clone git@github.com:DiegoSalazar/kwipper_challenge.git
    $ cd kwipper_challenge

Only supporting the Postgres database at the moment so assuming you have that installed you'll need to create the Kwipper db:

    $ ruby -r ./db/schema.rb -e schema_load

Then, create yourself a user by starting the console:

    $ irb -r ./lib/kwipper -r ./app/models/user

And run:

```ruby
User.create username: "shtuff", email: "some@email.com", hashed_password: "123"
```

## Usage

From the `kwipper_challenge` directory, start the server:

    $ ruby ./lib/kwipper.rb

Open the app in a browser at [http://localhost:7335](http://localhost:7335) and login with your user. There's no data seed right now so you'll have to create everything yourself.

## Backing up your local database

`pg_dump --inserts -d kwipper_development`

## Deploy on Heroku

For the Model to be able to connect to the database the `KWIPPER_DB_NAME` env var must be set. On Heroku this value can be found in the config (heroku env vars) it's called `DATABASE_URL`. The database connection options depend on RACK_ENV being either `development` or `production`.

When dumping a local database, the sql file's `OWNER TO x` statements have to be modified and `x` should be changed to the Heroku database username. That can be found by:

```SQL
-- to get Heroku db user, run bash, load kwipper, and run:
SELECT u.usename
FROM pg_database d
JOIN pg_user u ON (d.datdba = u.usesysid)
WHERE d.datname = (SELECT current_database());
```

## Contributing

1. Fork it ( https://github.com/DiegoSalazar/kwipper/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
