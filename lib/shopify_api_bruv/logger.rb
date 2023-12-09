# frozen_string_literal: true

require 'logger'

module ShopifyApiBruv
  def self.logger(method:, message:)
    logger = defined?(Rails) ? Rails.logger : Logger.new($stdout)
    enabled = ENV.fetch('SHOPIFY_API_BRUV_LOGGER_ENABLED', false) == 'true'

    logger.public_send(method, message) if enabled
  end
end
