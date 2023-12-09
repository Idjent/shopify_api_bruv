# frozen_string_literal: true

module ShopifyApiBruv
  module Resources
    module Graphql
      class Resource < Base
        attr_reader :client
        attr_accessor :query

        MAX_TRIES = ENV.fetch('SHOPIFY_API_BRUV_REQUEST_MAX_TRIES', 3).to_i
        SLEEP_TIMER = ENV.fetch('SHOPIFY_API_BRUV_REQUEST_SLEEP_TIMER', 4).to_i

        def initialize(config:)
          @client = Clients::Graphql::Client.new(config:)
        end

        def request(variables: nil, mutation_object_name: nil, tries: 0)
          raise NotImplementedError, 'Please set a query in the derived class' if query.nil?

          response = client.request(query:, variables:)

          handle_response(response:, query:, variables:, mutation_object_name:, tries:)
        end

        private

        def handle_response(response:, query:, variables:, mutation_object_name:, tries:)
          body = response.body

          handle_response_errors(body:, query:, variables:, tries:)

          mutation_object_name.nil? ? body['data'] : body.dig('data', mutation_object_name)
        end

        def handle_response_errors(body:, query:, variables:, tries:)
          errors = body['errors'] || body.dig('data', 'errors')

          raise Errors::ResourceError, errors if tries == MAX_TRIES

          if errors&.any? { |error| error['message'] == 'Throttled' }
            sleep(SLEEP_TIMER)

            request(tries: + 1)
          end

          raise Errors::ResourceError, errors unless errors.nil?
        end
      end
    end
  end
end
