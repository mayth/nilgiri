module Nilgiri
  class App < Padrino::Application
    register SassInitializer
    use ActiveRecord::ConnectionAdapters::ConnectionManagement
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers
    register Padrino::Sprockets
    sprockets paths: ["assets/prebuilt"]

    enable :sessions

    before do
      # For topbar navigations
      @machines = Machine.all
      @current_season = Season.for(:now)
    end
  end
end
