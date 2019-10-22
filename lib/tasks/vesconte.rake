namespace :vesconte do
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
    Rake::Task['vesconte:development'].invoke
  end

  desc "Grant administrative privileges to an existing user"
  task :add_admin, [:user_key] => :environment do |_task, args|
    abort "Usage: rake vesconte:add_admin [USER_EMAIL]" unless args[:user_key]

    admin = Role.find_or_create_by(name: "admin")
    user = User.find_by_user_key(args[:user_key])
    abort "The user #{args[:user_key]} could not be found" if user.nil?

    admin.users << user
    admin.save
  end
end
