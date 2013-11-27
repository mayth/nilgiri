if Padrino.env == :development
  module Rack
    module Protection
      class AuthenticityToken
        def accepts_with_allowed_path?(env)
          if defined?(Padrino::Application.exclude_from_protection)
            [Padrino::Application.exclude_from_protection].flatten.each do |path|
              return true if Regexp.new(path).match(env['REQUEST_PATH'])
            end
          end
          accepts_without_allowed_path?(env)
        end
        alias_method_chain :accepts?, :allowed_path
      end
    end
  end
end 
