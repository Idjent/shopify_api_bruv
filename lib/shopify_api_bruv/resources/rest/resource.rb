# frozen_string_literal: true

module ShopifyApiBruv
  module Resources
    module Rest
      class Resource < Base
        attr_reader :client, :method, :path, :body, :query

        SLEEP_TIMER = ENV.fetch('SHOPIFY_API_BRUV_REQUEST_SLEEP_TIMER', 4).to_i
        MINIMUM_CREDIT_LEFT = ENV.fetch('SHOPIFY_API_BRUV_REQUEST_MINIMUM_CREDIT_LEFT', 4).to_i

        def initialize(config:, method:, path:, body: nil, query: nil)
          @client = Clients::Rest::Client.new(config:)
          @method = method
          @path = path
          @body = body
          @query = query

          validate_arguments!
        end

        def request
          response = client.public_send(method, path:, body:, query:)

          handle_response(response:)
        end

        private

        def validate_arguments!
          if [:put, :post].include?(method)
            raise Errors::ResourceError, "Argument 'body' is required for method: #{method}" if body.nil?
          end
        end

        def handle_response(response:)
          handle_response_api_limits(headers: response.headers)

          body = response.body
          body['page_info'] = response.page_info if body.is_a?(Hash)
          body
        end

        def handle_response_api_limits(headers:)
          api_call_limit_header = headers['x-shopify-shop-api-call-limit'].split('/')

          limit = api_call_limit_header.pop.to_i - 1
          used = api_call_limit_header.shift.to_i

          if (limit - used) <= MINIMUM_CREDIT_LEFT
            sleep(SLEEP_TIMER)
          end
        end
      end
    end
  end
end
