require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# Precompiling assets failed. 対応
# config.assets.initialize_on_precompile = false

module SampleApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.i18n.default_locale = :ja

    #
    # # 生年月日を年齢として検索する。
    # # xx歳未満
    # config.add_predicate 'to_age_lt',
    #   arel_predicate: 'gteq',
    #   formatter: -> (v) { (v.years.ago + 1.day).to_date },
    #   type: :integer,
    #   compounds: false
    # # xx歳以下
    # config.add_predicate 'to_age_lteq',
    #   arel_predicate: 'gteq',
    #   formatter: -> (v) { ((v + 1).years.ago + 1.day).to_date },
    #   type: :integer,
    #   compounds: false
    # # xx歳以上
    # config.add_predicate 'to_age_gteq',
    #   arel_predicate: 'lteq',
    #   formatter: -> (v) { v.years.ago.to_date },
    #   type: :integer,
    #   compounds: false
    # # xx歳超過
    # config.add_predicate 'to_age_gt',
    #   arel_predicate: 'lteq',
    #   formatter: -> (v) { (v + 1).years.ago.to_date },
    #   type: :integer,
    #   compounds: false

  end
end
