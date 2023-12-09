# frozen_string_literal: true

module ShopifyApiBruv
  module Clients
    module Rest
      class Client
        attr_reader :config, :http_client

        def initialize(config:)
          @config = config
          @http_client = HttpClient.new(config:, path: "admin/api/#{config.api_version}")
        end

        def get(path:, body: nil, query: nil, headers: nil)
          request(method: :get, path:, body:, query:, headers:)
        end

        def delete(path:, body: nil, query: nil, headers: nil)
          request(method: :delete, path:, body:, query:, headers:)
        end

        def put(path:, body:, query: nil, headers: nil)
          request(method: :put, path:, body:, query:, headers:)
        end

        def post(path:, body:, query: nil, headers: nil)
          request(method: :post, path:, body:, query:, headers:)
        end

        private

        def request(method:, path:, body:, query:, headers:)
          http_client.request(
            http_request: HttpRequest.new(
              method:,
              path:,
              body:,
              content_type: body.nil? ? nil : 'application/json',
              headers:
            )
          )
        end
      end
    end
  end
end
