# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

require 'solr_wrapper/rake_task' unless Rails.env.production?

namespace :geohyrax do
  desc "Start Solr and Fedora"
  task :development do
    with_server(ENV['RAILS_ENV'] || 'development') do
      puts "Fedora: #{ActiveFedora.config.credentials[:url]}"
      puts "Solr..: #{ActiveFedora.solr_config[:url]}"
      begin
        puts "^C to exit"
        sleep
      rescue Interrupt
        puts "Stopping server"
      end
    end
  end

  desc "Start Solr and Fedora for executing test suites"
  task :test do
    ENV['RAILS_ENV'] = 'test'
    Rake::Task['geohyrax:development'].invoke
  end
end
