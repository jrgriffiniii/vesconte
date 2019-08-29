# Hyrax for Geospatial Works

## Starting this application

```
bundle install
bundle exec rails db:migrate
bundle exec rails hyrax:default_admin_set:create
bundle exec rails s
```

Sign up for a new account using: http://localhost:3000/users/sign_up?locale=en

After this is finished, please return to the command line interface:
```
bundle exec rails c
admin = Role.create(name: "admin")
admin.users << User.find_by_user_key( "your_admin_users_email@fake.email.org" )
admin.save
```
