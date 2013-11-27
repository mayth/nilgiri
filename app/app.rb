module Nilgiri
  class App < Padrino::Application
    register SassInitializer unless Padrino.env == :production
    use ActiveRecord::ConnectionAdapters::ConnectionManagement
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers
    register Padrino::Sprockets
    sprockets

    enable :sessions
  end
end
