module FlickJsonApi
  # A [Custom Model Parser](https://github.com/ruby-grape/grape-swagger#custom-model-parsers)
  # to introspect the attributes exposed by FastJsonapi in order to provide documentation for Grape-Swagger
  class Introspector
    attr_reader :model
    attr_reader :endpoint

    def initialize(model, endpoint)
      @model = model
      @endpoint = endpoint
    end

    def call
      [model.attribute_documentation, []]
    end
  end
end
