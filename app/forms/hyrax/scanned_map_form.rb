# Generated via
#  `rails generate hyrax:work ScannedMap`
module Hyrax
  # Generated form for ScannedMap
  class ScannedMapForm < Hyrax::Forms::WorkForm
    self.model_class = ::ScannedMap
    self.terms += [:resource_type, :coverage]
    self.required_fields += [:coverage]
  end
end
