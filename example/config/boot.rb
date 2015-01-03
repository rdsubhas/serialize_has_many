ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)
ENV['RAILS_ENV'] = 'test'

require 'bundler/setup' # Set up gems listed in the Gemfile.
