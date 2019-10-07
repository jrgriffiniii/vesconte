
class WellKnownTextLiteral < RDF::Literal
  def initialize(value = nil, **properties)
    super.new(self.class.convert(value), datatype: "http://www.opengis.net/ont/geosparql#wktLiteral")
  end

  def self.new(value = nil, **properties)
    RDF::Literal.new(self.convert(value), datatype: "http://www.opengis.net/ont/geosparql#wktLiteral")
  end

  def self.convert(value)
    return nil if value.blank?

    bounding_box_match = /northlimit=(.+?); eastlimit=(.+?); southlimit=(.+?); westlimit=(.+?);/.match(value)
    return nil unless bounding_box_match

    northlimit = bounding_box_match[1]
    eastlimit = bounding_box_match[2]
    southlimit = bounding_box_match[3]
    westlimit = bounding_box_match[4]

    sw = [westlimit, southlimit]
    nw = [westlimit, northlimit]
    ne = [eastlimit, northlimit]
    se = [eastlimit, southlimit]

    wkt = "POLYGON (("
    wkt += sw.join(' ')
    wkt += ', '
    wkt += nw.join(' ')
    wkt += ', '
    wkt += ne.join(' ')
    wkt += ', '
    wkt += se.join(' ')
    wkt += ', '
    wkt += sw.join(' ')
    wkt += "))"

    wkt
  end
end
