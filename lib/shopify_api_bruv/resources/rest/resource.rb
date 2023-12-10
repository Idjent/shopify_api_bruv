# frozen_string_literal: true

module ShopifyApiBruv
  module Resources
    module Rest
      class Resource < Base
        attr_reader :client, :method, :path, :body
        attr_accessor :query, :pagination

        SLEEP_TIMER = ENV.fetch('SHOPIFY_API_BRUV_RESOURCE_REST_SLEEP_TIMER', 4).to_i
        CREDIT_LEFT_THRESHOLD = ENV.fetch('SHOPIFY_API_BRUV_RESOURCE_REST_CREDIT_LEFT_THRESHOLD', 8).to_i

        def initialize(config:, method:, path:, body: nil, query: nil)
          @client = Clients::Rest::Client.new(config:)
          @method = method
          @path = path
          @body = body
          @query = query

          validate_arguments
        end

        def call
          response = client.public_send(method, path:, body:, query:)

          handle_response_api_limits(headers: response.headers)

          pagination = Pagination.new(resource: self, page_info: response.page_info)
          @pagination = pagination if pagination.purpose?

          response.body
        end

        private

        def validate_arguments
          if [:put, :post].include?(method)
            raise Errors::ResourceError, "Argument 'body' is required for method: #{method}" if body.nil?
          end
        end

        def handle_response_api_limits(headers:)
          api_call_limit_header = headers['x-shopify-shop-api-call-limit'].split('/')

          limit = api_call_limit_header.pop.to_i - 1
          used = api_call_limit_header.shift.to_i

          if (limit - used) <= CREDIT_LEFT_THRESHOLD
            sleep(SLEEP_TIMER)
          end
        end
      end
    end
  end
end
