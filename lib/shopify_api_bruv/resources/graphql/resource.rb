# frozen_string_literal: true

module ShopifyApiBruv
  module Resources
    module Graphql
      class Resource < Base
        attr_reader :client
        attr_accessor :variables, :query

        QUERY = nil
        MAX_TRIES = ENV.fetch('SHOPIFY_API_BRUV_RESOURCE_GRAPHQL_MAX_TRIES', 3).to_i
        SLEEP_TIMER = ENV.fetch('SHOPIFY_API_BRUV_RESOURCE_GRAPHQL_SLEEP_TIMER', 4).to_i

        def initialize(config:, variables: nil)
          @client = Clients::Graphql::Client.new(config:)
          @variables = variables
          @query = self.class::QUERY unless self.class::QUERY.nil?
        end

        def call(tries: 0)
          if query.nil?
            raise Errors::ResourceError, "Please set attribute 'query' or define constant 'QUERY' in derived class"
          end

          response = client.request(query:, variables:)

          handle_response_errors(body: response.body, query:, variables:, tries:)

          ResourceResponse.new(body: response.body, query:)
        end

        private

        def handle_response_errors(body:, query:, variables:, tries:)
          errors = body['errors'] || body.dig('data', 'errors')

          raise Errors::ResourceResponseError, errors if tries == MAX_TRIES

          if errors&.any? { |error| error['message'] == 'Throttled' }
            sleep(SLEEP_TIMER)

            call(tries: + 1)
          end

          raise Errors::ResourceResponseError, errors unless errors.nil?
        end
      end
    end
  end
end
