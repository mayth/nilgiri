Nilgiri
=======

TEA party score registration tool

[![Build Status](https://travis-ci.org/mayth/nilgiri.png?branch=master)](https://travis-ci.org/mayth/nilgiri)

Requirements
============

* Ruby 2.0
* Bundler
* SQLite3 for development/testing
* PostgreSQL for production

Setup
=====

1. `git clone https://github.com/mayth/nilgiri.git`
2. `cd nilgiri`
3. `bundle install --path vendor/gems`
4. `bundle exec padrino start`

Deployment
==========

Asset Precompile
----------------

`rake assets` generates precompiled assets in `app/assets/prebuilt`.
If you want to deploy this app to heroku, you must do `heroku run rake assets`
to precompile assets and your dyno must be waken up to prevent idling.
CSS/Sass files this app has is too large to compile when it is requested :(

Licence
=======
Licensed under MIT License. See 'LICENSE'.
