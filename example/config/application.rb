require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Example
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
    config.assets.enabled = false
    config.generators do |g|
      g.test_framework nil, fixture: false
      g.view_specs false
      g.helper_specs false
    end
  end
end
