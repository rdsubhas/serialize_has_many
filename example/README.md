# Quickstart

    bundle install

    # Run development server:
    bundle exec rake db:migrate
    bundle exec rails server -b 0.0.0.0

    # Run unit tests:
    RAILS_ENV=test rake db:migrate
    bundle exec rspec
