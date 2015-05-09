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

Start the server:

    $ ruby lib/kwipper.rb

Open the app in a browser at [http://localhost:7335](http://localhost:7335) and login with your user. There's no data seed right now so you'll have to create everything yourself.

## Contributing

1. Fork it ( https://github.com/DiegoSalazar/kwipper/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
