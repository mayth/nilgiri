Nilgiri
=======

TEA party score registration tool

[![Build Status](https://travis-ci.org/mayth/nilgiri.png)](https://travis-ci.org/mayth/nilgiri)

Requirements
============

* Ruby 2.1
* Bundler
* PostgreSQL

Setup
=====

First, clone the repository.

    % git clone https://github.com/mayth/nilgiri.git

Install gems.

    % bundle install --path vendor/gems

Generate 'springified' executable in `bin/`. (For more information about `spring`, see: [rails/spring](https://github.com/rails/spring))

    % bundle exec spring binstub --all

Note: In the instructions below, we assume that `bin/` is added to `$PATH` (using [direnv](http://direnv.net)). If you do not so, use the executables in `bin/` explicitly, like `bin/rake`.

Setup the application environment variables. Rename `config/application.example.yml` to `config/application.yml`, and edit it. (You can generate secret keys by `rake secret`)

Prepare the database. First, create a user. (Be sure that you can create users and databases for PostgreSQL.)

    % createuser nilgiri -P
    % createdb nilgiri_development -O nilgiri
    % createdb nilgiri_test -O nilgiri

Or, you may grant to create databases for the new user. In this case, instead of run `createdb`,

    % rake db:create

Done the job, run the migrations and seeding.

    % rake db:migrate
    % rake db:seed

Create the admin user.

    % rake admin:create_user EMAIL='your-email-address@example.com' PASSWORD='password'

Let's go!

    % bundle exec foreman start

And open `http://localhost:5000` with your browser.

Deployment
==========

Simply push the repository to heroku.

Nilgiri uses [figaro](https://github.com/laserlemon/figaro), so the config vars can be set by `rake figaro:heroku`.

Licence
=======
Nilgiri is licensed under the MIT License. See 'LICENSE'.

Copyright
=========

Copyright (C) 2014 mayth (Mei Akizuru) [@maytheplic](https://twitter.com/maytheplic)
