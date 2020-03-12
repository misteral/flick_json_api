# frozen_string_literal: true

require "rails/railtie"

module FlickJsonApi
  class Railtie < Rails::Railtie
    initializer "flick_json_api.grape_swagger" do
      if defined?(GrapeSwagger)
        GrapeSwagger.model_parsers.register(FlickJsonApi::Introspector, FlickJsonApi::Serializer)
      end
    end
  end
end
