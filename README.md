# Kwipper

Kwipper is the reference example app for the Kwipper Programming Challenge. See more information on the live app [demo](#soon).

## Installation

    $ git clone git@github.com:DiegoSalazar/kwipper_challenge.git

## Usage

Create yourself a user by starting the console:

    $ irb -r ./lib/kwipper -r ./app/models/user

And running:

```ruby
User.create 'username' => 'a username', 'email' => 'optional@mail.com', 'hashed_password' => '123'
```

Start the server:

    $ ruby lib/kwipper.rb

Open the app in a browser at [http://localhost:7335](http://localhost:7335).

## Contributing

1. Fork it ( https://github.com/DiegoSalazar/kwipper/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
