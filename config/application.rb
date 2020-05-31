require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FrePreSNS
  class Application < Rails::Application
    config.load_defaults 5.2
    config.i18n.default_locale = :ja
    config.generators.template_engine = :slim
    config.time_zone = 'Tokyo'
    Time::DATE_FORMATS[:datetime_jp] = '%Y/%m/%d %H:%M:%S'
    Time::DATE_FORMATS[:date_jp] = '%Y/%m/%d'
    Time::DATE_FORMATS[:dateweek_jp] = '%Y/%m/%d %a %H:%M'
    config.generators do |g|
      g.test_framework :rspec,
        view_specs: false,
        helper_specs: false,
        routing_specs: false
    end
    config.assets.paths << Rails.root.join('public')
    config.assets.precompile << %w( cancel-off.png cencel-on.png star-off.png star-on.png star-half.png)
  end
end
