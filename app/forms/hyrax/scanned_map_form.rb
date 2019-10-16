# Generated via
#  `rails generate hyrax:work ScannedMap`
module Hyrax
  # Generated form for ScannedMap
  class ScannedMapForm < Hyrax::Forms::WorkForm
    self.model_class = ::ScannedMap
    self.terms += [:resource_type, :coverage]
    self.required_fields += [:coverage]

    def self.spatial_fields
      [:coverage]
    end

    def self.single_valued_fields
      [:coverage]
    end

    def self.multiple?(field)
      if single_valued_fields.include?(field.to_sym)
        false
      else
        super
      end
    end

    # This provides the casting for RDF literals
    # Until these are natively handled by ActiveTriples, this will be necessary
    def self.model_attributes(_form_params)
      super.tap do |processed_params|
        terms.each do |term|
          if spatial_fields.include?(term)
            existing_values = processed_params[term] || []
            processed_params[term] = existing_values.map { |spatial| WellKnownTextLiteral.new(spatial) }
          end
        end
      end
    end
  end
end
