# Generated via
#  `rails generate hyrax:work ScannedMap`
class ScannedMap < ActiveFedora::Base
  include ::Hyrax::WorkBehavior

  self.indexer = ScannedMapIndexer
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []
  validates :title, presence: { message: 'Your work must have a title.' }

  # Defines the bounding box for the layer.
  # The values are structured using the Well-Known Text standard.
  # @example
  #   vector.coverage = ['POLYGON ((10 10, 40 10, 40 40, 10 40, 10 10))']
  property :coverage, predicate: ::RDF::Vocab::DC11.coverage, class_name: 'WellKnownTextLiteral'

  # This must be included at the end, because it finalizes the metadata
  # schema (by adding accepts_nested_attributes)
  include ::Hyrax::BasicMetadata
end
