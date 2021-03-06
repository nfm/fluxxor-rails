require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Populate ENV with values from .env in development and test environments
if Rails.env.development? || Rails.env.test?
  File.read('.env').gsub("\r\n","\n").split("\n").each do |line|
    if line =~ /\A([A-Za-z_0-9]+)=(.*)\z/
      key = $1
      val = $2

      case val
        # Remove single quotes
        when /\A'(.*)'\z/ then ENV[key] = $1
        # Remove double quotes and unescape string preserving newline characters
        when /\A"(.*)"\z/ then ENV[key] = $1.gsub('\n', "\n").gsub(/\\(.)/, '\1')
        else ENV[key] = val
      end
    end
  end
end

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
ENVied.require(*ENV['ENVIED_GROUPS'] || Rails.groups)

module Fluxxor
  class Application < Rails::Application
    # Use system-js for Sprockets ES6 modules
    Rails.application.config.assets.configure do |env|
      env.register_transformer 'text/ecmascript-6', 'application/javascript', Sprockets::ES6.new('modules' => 'system', 'moduleIds' => true)
    end


    # Configure generators
    config.generators do |g|
      g.stylesheets false
      g.javascripts false
      g.helper false
    end

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
  end
end
