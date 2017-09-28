# _recipe-project_

#### By Rafael Furry & Erik Zakrzewski

##### This application is a demonstration application designed to show a many-to-many relationship between recipes and categories as well as recipes and ingredients using Active Record.

## Technologies Used

Application: Ruby, Sinatra, Active Record<br>
Testing: Rspec, Capybara<br>
Database: Postgres

Installation
------------

```
$ git clone https://github.com/BullThistle/recipes.git
```

Install required gems:
```
$ bundle install
```

Create databases:
```
rake db:create
rake db:schema:load
```

Start the webserver:
```
$ ruby app.rb
```

Navigate to `localhost:4567` in browser.

License
-------

GNU GPL v2. Copyright 2015 **Rafael Furry and Erik Zakrzewski**
