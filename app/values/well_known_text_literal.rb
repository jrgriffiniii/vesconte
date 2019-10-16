
class WellKnownTextLiteral < RDF::Literal
  def initialize(value = nil, **properties)
    super.new(self.class.convert(value), datatype: "http://www.opengis.net/ont/geosparql#wktLiteral")
  end

  def self.new(value = nil, **properties)
    RDF::Literal.new(self.convert(value), datatype: "http://www.opengis.net/ont/geosparql#wktLiteral")
  end

  def self.parse(rdf_wkt_literal)
    wkt_literal = rdf_wkt_literal.to_s

    wkt_regex = /POLYGON \(\((\-?\d.+?) (\-?\d.+?), \-\d.+? (\-?\d.+?), (\-?\d.+?) /
    wkt_match = wkt_regex.match(wkt_literal)
    return unless wkt_match

    northlimit = wkt_match[3]
    eastlimit = wkt_match[4]
    southlimit = wkt_match[2]
    westlimit = wkt_match[1]

    "northlimit=#{northlimit}; eastlimit=#{eastlimit}; southlimit=#{southlimit}; westlimit=#{westlimit};"
  end

  def self.convert(value)
    return nil if value.blank?

    bounding_box_regex = /northlimit=(.+?); eastlimit=(.+?); southlimit=(.+?); westlimit=(.+?);/
    bounding_box_match = bounding_box_regex.match(value)
    return nil unless bounding_box_match

    northlimit = bounding_box_match[1]
    eastlimit = bounding_box_match[2]
    southlimit = bounding_box_match[3]
    westlimit = bounding_box_match[4]

    sw = [westlimit, southlimit]
    nw = [westlimit, northlimit]
    ne = [eastlimit, northlimit]
    se = [eastlimit, southlimit]

    wkt = "<http://www.opengis.net/def/crs/OGC/1.3/CRS84> POLYGON (("
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
