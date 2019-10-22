# frozen_string_literal: true

class RdfLiteralSerializer < ActiveJob::Serializers::ObjectSerializer
  def serialize(argument)
    super("value" => argument.to_s)
  end

  def deserialize(argument)
    argument["value"].to_sym
  end

  private

    def klass
      RDF::Literal
    end
end
