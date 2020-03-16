module FlickJsonApi
  # Extends FastJsonapi#attribute with additional documentation options
  class Serializer
    include FastJsonapi::ObjectSerializer

    class << self
      alias attribute_without_documentation attributes

      # Prevent the original method from being called without documentation
      undef_method :attributes

      def attribute_documentation
        @attribute_documentation ||= {}
      end

      # @param name [Symbol] Name (JSON key)
      # @param type [String, Array<String>] One of array, boolean, integer, number, null, object, string, or an array of one or more of these types
      # @param format [String] [Data type format](https://swagger.io/specification/v2/#dataTypeFormat)
      # @param enum [Array<Any>] A [JSON Schema enumeration](https://tools.ietf.org/html/draft-fge-json-schema-validation-00#section-5.5.1)
      # @param description [String] Description. [GFM syntax](https://guides.github.com/features/mastering-markdown/#GitHub-flavored-markdown) can be used.
      # @param items [Hash] An [OpenAPI Items Object](https://swagger.io/specification/v2/#itemsObject), if this attribute is an array
      # @param properties [Hash] A hash of properties, if this attribute is an object, the values of which are JSON Schemas (repeat these attributes again!)
      # @param examples [Array<Any>] Example values (Swagger documentation)
      # @param options [Hash] Additional options to pass to FastJsonapis
      # @see https://swagger.io/specification/v2/#schemaObject
      def attribute(name, type: nil, format: nil, enum: nil, description: nil, items: nil, properties: nil, examples: nil, documentation: nil, **options, &block)
        # backwards compatibility
        description ||= documentation

        documentation = {
          type: type,
          format: format,
          enum: enum,
          description: description,
          examples: examples,
          items: items,
          properties: properties
        }.compact

        attribute_documentation[name] ||= documentation

        attribute_without_documentation(name, options, &block)
      end
    end

    def attribute_documentation
      self.class.attribute_documentation
    end
  end
end
