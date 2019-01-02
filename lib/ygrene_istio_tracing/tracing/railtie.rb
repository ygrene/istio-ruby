# frozen_string_literal: true

require 'rails/railtie'

module YgreneIstioTracing
  module Tracing
    class Railtie < ::Rails::Railtie
      initializer 'ygrene_istio_tracing.insert_middleware' do |app|
        app.middleware.use YgreneIstioTracing::Tracing::RackMiddleware
      end
    end
  end
end
