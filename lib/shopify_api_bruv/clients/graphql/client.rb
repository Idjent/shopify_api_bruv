# frozen_string_literal: true

module ShopifyApiBruv
  module Clients
    module Graphql
      class Client
        attr_reader :config, :http_client

        def initialize(config:)
          @config = config
          @http_client = HttpClient.new(config:, path: "admin/api/#{config.api_version}")
        end

        def request(query:, variables: nil, headers: nil)
          http_client.request(
            http_request: HttpRequest.new(
              api: :graphql,
              method: :post,
              path: '/graphql.json',
              body: { query:, variables: },
              content_type: 'application/json',
              headers:
            )
          )
        end
      end
    end
  end
end
