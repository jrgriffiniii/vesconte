# Generated via
#  `rails generate hyrax:work ScannedMap`
module Hyrax
  class ScannedMapPresenter < Hyrax::WorkShowPresenter
    delegate :coverage, to: :solr_document

    def attribute_to_html(field, options = {})
      if field == :coverage
        GeoWorks::CoverageRenderer.new(field, send(field), options).render
      else
        super field, options
      end
    end
  end
end
