# frozen_string_literal: true

require "fast_jsonapi/object_serializer"
require "flick_json_api/serializer"
require "flick_json_api/introspector"

if defined?(::Rails)
  require "fast_jsonapi/railtie"
  require "flick_json_api/railtie"
elsif defined?(::ActiveRecord)
  require "extensions/has_one"
end
