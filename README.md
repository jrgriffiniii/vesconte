# Vesconte
_This is a [Hyrax](https://github.com/samvera/hyrax) implementation used for
demonstrating support for geospatial works._

## Getting started

### Prerequisites

Vesconte requires the following software to work:

1. A SQL RDBMS (MySQL, PostgreSQL), though **note** that SQLite will be used by 
default if you're looking to get up and running quickly
1. [Redis](http://redis.io/), a key-value store
1. [ImageMagick](http://www.imagemagick.org/) with JPEG-2000 support
1. [FITS](#characterization) version 1.0.x (1.0.5 is known to be good, 1.1.0 is
   known to be bad: https://github.com/harvard-lts/fits/issues/140)
1. [Fedora Commons]() version 4.7.5
1. [Apache Solr]() version 7.7.2

#### Characterization

FITS can be installed on OSX using Homebrew by running the command: `brew 
install fits`

### Ruby

First, you'll need a working Ruby installation. You can install this via your
operating system's package manager -- you are likely to get farther with OSX,
Linux, or UNIX than Windows but your mileage may vary -- but we recommend using
a Ruby version manager such as [RVM](https://rvm.io/) or
[rbenv](https://github.com/sstephenson/rbenv).

Vesconte supports Ruby 2.4, 2.5, and 2.6. When starting a new project, we
recommend using the latest Ruby 2.6 version.

### Redis

[Redis](http://redis.io/) is a key-value store that Hyrax uses to provide
activity streams on repository objects and users, and to prevent race conditions
as a global mutex when modifying order-persisting objects.

Starting up Redis will depend on your operating system, and may in fact already
be started on your system. You may want to consult the [Redis
documentation](http://redis.io/documentation) for help doing this.

### Rails

Hyrax requires Rails 5. This currently uses Rails 5.1.7 release. An upgrade path
to 5.2.3 (or later) will be available once Hyrax 3.0.0 or a later 2.y.z release 
than 2.5.1 is available.

### JavaScript runtime

Rails requires that you have the JavaScript runtime `nodejs` installed.
NOTE: nodejs is preinstalled on most Mac computers and doesn't require a gem.
To test if nodejs is already installed, execute `node -v` in the terminal and
the version of nodejs will be displayed if it is installed.

### Starting the background workers

Many of the services performed by Hyrax are resource intensive, and therefore
are well suited to running as background jobs that can be managed and executed
by a message queuing system. Examples include:

* File ingest
* Derivative generation
* Characterization
* Fixity
* Solr indexing

Hyrax implements these jobs using the Rails
[ActiveJob](http://edgeguides.rubyonrails.org/active_job_basics.html) framework,
allowing you to choose the message queue system of your choice.

For initial development, the ActiveJob adapter is *set by default* to `:inline`.
 This adapter will execute jobs immediately (in the foreground) as they are 
received. This was set by adding the following to the file 
`config/environments/development.rb`

```
class Application < Rails::Application
  # ...
  config.active_job.queue_adapter = :inline
  # ...
end
```

For testing, it is recommended that you use the [built-in `:test`adapter]
(http://api.rubyonrails.org/classes/ActiveJob/QueueAdapters/TestAdapter.html)
which stores enqueued and performed jobs, running only those configured to run
during test setup. To do this, add the following to
`config/environments/test.rb`:

```ruby
Rails.application.configure do
  # ...
  config.active_job.queue_adapter = :test
  # ...
end
```

**For production applications** you will want to use a more robust message queue
system such as [Sidekiq](http://sidekiq.org/). The Hyrax Development Guide has a
detailed walkthrough of [installing and configuring
Sidekiq](https://github.com/samvera/hyrax/wiki/Using-Sidekiq-with-Hyrax).

### Create default administrative set

Before starting the app, please create the default administrative set -- into 
which all works will be deposited unless assigned to other administrative sets 
-- by running the following command:

```
bundle exec rails hyrax:default_admin_set:create
```

This command also makes sure that Hyrax's built-in workflows are loaded for your
application and available for the default administrative set.

**NOTE**: You will want to run this command the first time this code is deployed
to a new environment as well.

#### Troubleshooting
One may encounter the following error if the admin. set has to be recreated
under certain circumstances (e. g. a different Fedora Commons is used).  One may
encounter the following error:

```bash
UNIQUE constraint failed: permission_templates.source_id
```

This indicates that the permission template for the admin. set already exists in
the database. A solution for this is to reset the database:

```bash
bundle exec rails db:reset
```

Unfortunately, one *will* need to re-run `bundle exec rails db:migrate` and
re-grant their own user admin. privileges.

### Creating an administrative user account

Create a new user using your e-mail address (e. g. your_email@fake.email.org)
http://localhost:3000/users/sign_up?locale=en

Grant administrative privileges to your new user:
```
$ bundle exec rails c
admin = Role.create(name: "admin")
admin.users << User.find_by_user_key( "your_email@fake.email.org" )
admin.save
```

### Starting the application

To test-drive your new Hyrax application in development mode, spin up the
servers that Hyrax needs (Solr, Fedora, and Rails):

```
bundle install
bundle exec rails db:migrate
FCREPO_URL=http://localhost:8984/rest SOLR_URL=http://localhost:8983/solr/hydra-development bundle exec rails server
```

_Note, for working with a Fedora Commons Docker container, one must use a different URL structure:
`http://[FCREPO_FQDN]:8080/fcrepo/rest`

And now you should be able to browse to [localhost:3000](http://localhost:3000/)
and see the application.

## Customization and Development
### Generate a work type

Using Hyrax requires generating at least one type of repository object, or "work
type." Hyrax allows you to generate the work types required in your application
by using a Rails generator-based tool. You may generate one or more of these
work types.

Pass a (CamelCased) model name to Hyrax's work generator to get started, e.g.:

```
bundle exec rails generate hyrax:work SpatialWork
```

If your applications requires your work type to be namespaced, namespaces can be
included in the by adding a slash to the model name which creates a new class
called `SpatialWork` within the `My` namespace:

```
bundle exec rails generate hyrax:work My/SpatialWork
```

# Acknowledgments

This software has been developed by and is brought to you by the Samvera 
community.  Learn more at the [Samvera website](http://samvera.org/).

![Samvera Logo](https://wiki.duraspace.org/download/thumbnails/87459292/samvera-fall-font2-200w.png?version=1&modificationDate=1498550535816&api=v2)
