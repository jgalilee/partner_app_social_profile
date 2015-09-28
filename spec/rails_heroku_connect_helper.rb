# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require 'rails_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'

# Necessary to ensure sessions between Capybara selenium tests don't hang or
# have records not seen by the other instance
class ActiveRecord::Base
  mattr_accessor :shared_connection
  @@shared_connection = {}

  def self.connection
    @@shared_connection[self.connection_config[:database]] ||= retrieve_connection
  end
end

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.before(:each) do
    DatabaseCleaner.clean_with :truncation
  end

  config.before(:each) do |example|
    if example.metadata[:js]
      DatabaseCleaner.strategy = :truncation
    else
      DatabaseCleaner.strategy = :transaction
    end
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

