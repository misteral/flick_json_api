# frozen_string_literal: true

require "fast_jsonapi/object_serializer"

if defined?(::Rails)
  require "flick_json_api/railtie"
elsif defined?(::ActiveRecord)
  require "extensions/has_one"
end
