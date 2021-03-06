require_relative 'boot'

require 'rails/all'
require 'active_job/arguments'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Vesconte
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # This enables RDF::Literal attribute values to be offered in arguments for
    # the ActiveJob
    # Please see https://github.com/rails/rails/blob/5-1-stable/activejob/lib/active_job/arguments.rb#L25
    ::ActiveJob::Arguments::TYPE_WHITELIST.push(RDF::Literal)
  end
end
