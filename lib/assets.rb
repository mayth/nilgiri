module Nilgiri
  module Assets
    class Environment
      def self.get(root, preprocess = false)
        env = Sprockets::Environment.new(root)

        env.append_path 'assets/javascripts'
        env.append_path 'assets/stylesheets'
        env.append_path 'assets/images'

        if preprocess
          env.css_compressor = YUI::CssCompressor.new
          env.register_postprocessor 'application/javascript', Sprockets::JSMinifier
        end

        env
      end
    end
  end
end
