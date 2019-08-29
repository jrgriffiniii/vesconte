# Generated via
#  `rails generate hyrax:work ScannedMap`
module Hyrax
  # Generated controller for ScannedMap
  class ScannedMapsController < ApplicationController
    # Adds Hyrax behaviors to the controller.
    include Hyrax::WorksControllerBehavior
    include Hyrax::BreadcrumbsForWorks
    self.curation_concern_type = ::ScannedMap

    # Use this line if you want to use a custom presenter
    self.show_presenter = Hyrax::ScannedMapPresenter
  end
end
