# Generated via
#  `rails generate hyrax:work ScannedMap`
class ScannedMap < ActiveFedora::Base
  include ::Hyrax::WorkBehavior

  self.indexer = ScannedMapIndexer
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []
  validates :title, presence: { message: 'Your work must have a title.' }

  # Defines the bounding box for the layer.
  # We always assert units of decimal degrees and EPSG:4326 projection.
  # @see http://dublincore.org/documents/dcmi-box/
  # @example
  #   vector.coverage = 'northlimit=43.039; eastlimit=-69.856; southlimit=42.943; westlimit=-71.032; units=degrees; projection=EPSG:4326'
  property :coverage, predicate: ::RDF::Vocab::DC11.coverage, multiple: false

  # This must be included at the end, because it finalizes the metadata
  # schema (by adding accepts_nested_attributes)
  include ::Hyrax::BasicMetadata
end
