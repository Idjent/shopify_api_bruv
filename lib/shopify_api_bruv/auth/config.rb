# frozen_string_literal: true

module ShopifyApiBruv
  module Auth
    class Config
      attr_reader :api_domain, :api_version, :api_access_token

      def initialize(api_domain:, api_version:, api_access_token:)
        @api_domain = api_domain
        @api_version = api_version
        @api_access_token = api_access_token
      end
    end
  end
end
