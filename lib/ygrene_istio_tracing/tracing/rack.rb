# frozen_string_literal: true

module YgreneIstioTracing
  module Tracing
    class RackMiddleware

      def initialize(app)
        puts 'Tracing Loaded'
        @app = app
      end

      def call(env)
        Context.build_current(extract_http_headers(env))
        @app.call(env)
      ensure
        Context.remove_current
      end

      def extract_http_headers(env)
        keys = env.transform_keys do |k|
          k.upcase.gsub(/^HTTP_/, '').tr('_', '-')
        end
        keys.select do |k, _v|
          PROPAGATION_HEADERS.include?(k)
        end
      end
    end
  end
end
