require "spec_helper"

RSpec.describe FlickJsonApi do
  Square = Struct.new(:id, :name, :size)

  class SquareSerializer < FlickJsonApi::Serializer
    attribute :id
    attribute :name, type: "string", documentation: "Name of the square", examples: ["Fred"], enum: ["Fred", "Alice"]
    attribute :size, type: "integer", format: "int32", documentation: "Size of the square", examples: [32], if: proc { |_record| true }
  end

  let(:record) { Square.new("365", "Fred", 32) }
  let(:model) { SquareSerializer.new(record) }
  let(:endpoint) { double("grape endpoint") }

  it "produces a hash in jsonapi format" do
    result = model.serializable_hash

    expect(result).to eq(
      data: { attributes: { id: "365", name: "Fred", size: 32 }, id: "365", type: :square }
    )
  end

  it "produces a hash of json api attribute documentation" do
    properties, required = FlickJsonApi::Introspector.new(model, endpoint).call

    expect(required).to eq([])
    expect(properties).to eq(
      id: {},
      name: { description: "Name of the square", enum: ["Fred", "Alice"], examples: ["Fred"], type: "string" },
      size: { description: "Size of the square", examples: [32], format: "int32", type: "integer" }
    )
  end
end
