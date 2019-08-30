
class WellKnownTextLiteral < RDF::Literal
  def initialize(value = nil, **properties)
    super.new(self.class.convert(value), datatype: "http://www.opengis.net/ont/geosparql#wktLiteral")
  end

  def self.new(value = nil, **properties)
    RDF::Literal.new(self.convert(value), datatype: "http://www.opengis.net/ont/geosparql#wktLiteral")
  end

  def self.convert(value)
    return nil if value.blank?

    # This needs to actually be implemented
    "POLYGON ((10 10, 40 10, 40 40, 10 40, 10 10))"
  end
end
