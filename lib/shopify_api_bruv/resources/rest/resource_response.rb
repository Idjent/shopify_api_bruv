# frozen_string_literal: true

module ShopifyApiBruv
  module Resources
    module Rest
      class ResourceResponse
        attr_accessor :data
        attr_reader :credit_limit, :credit_used, :credit_left

        CREDIT_LEFT_THRESHOLD = ENV.fetch('SHOPIFY_API_BRUV_RESOURCE_REST_CREDIT_LEFT_THRESHOLD', 8).to_i

        def initialize(body:, headers:)
          @data = body

          parse_api_call_limit(headers:)
        end

        def as_open_struct
          # rubocop:disable Style/OpenStructUse
          JSON.parse(data.to_json, object_class: OpenStruct)
          # rubocop:enable Style/OpenStructUse
        end

        def credit_left?
          credit_left > CREDIT_LEFT_THRESHOLD
        end

        private

        def parse_api_call_limit(headers:)
          api_call_limit_header = headers['x-shopify-shop-api-call-limit'].split('/')

          @credit_limit = api_call_limit_header.pop.to_i - 1
          @credit_used = api_call_limit_header.shift.to_i
          @credit_left = credit_limit - credit_used
        end
      end
    end
  end
end
