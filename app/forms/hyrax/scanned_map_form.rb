# Generated via
#  `rails generate hyrax:work ScannedMap`
module Hyrax
  # Generated form for ScannedMap
  class ScannedMapForm < Hyrax::Forms::WorkForm
    self.model_class = ::ScannedMap
    self.terms += [:resource_type, :coverage]
    self.required_fields += [:coverage]

    # This provides the casting for RDF literals
    # Until these are natively handled by ActiveTriples, this will be necessary
    def self.model_attributes(_form_params)
      super.tap do |processed_params|
        terms.each do |key|
          if key == :coverage
            # This should also check for multiple?
            existing_values = processed_params[key] || []
            processed_params[key] = existing_values.map { |spatial| WellKnownTextLiteral.new(spatial) }
          end
        end
      end
    end
  end
end
