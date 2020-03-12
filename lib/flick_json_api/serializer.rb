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

      # @param name [Symbol] Attribute name (JSON key)
      # @param type [String] Attribute type (Swagger documentation). One of integer, number, string, boolean
      # @param format [String] Attribute format (Swagger documentation). One of int32, int64, float, double, byte, binary, date, date-time, password
      # @param enum [Array<Object>] Valid attribute values, if an enumeration
      # @param documentation [String] Attribute documentation (for Swagger)
      # @param examples [Array<Object>] Example values (Swagger documentation)
      # @param options [Hash] Additional options to pass to FastJsonapi
      def attribute(name, type: nil, format: nil, enum: nil, documentation: nil, examples: nil, **options, &block)
        attribute_documentation[name] ||= { type: type, format: format, enum: enum, documentation: documentation, examples: examples }.compact

        attribute_without_documentation(name, options, &block)
      end
    end

    def attribute_documentation
      self.class.attribute_documentation
    end
  end
end
