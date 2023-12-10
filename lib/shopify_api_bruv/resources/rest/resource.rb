# frozen_string_literal: true

module ShopifyApiBruv
  module Resources
    module Rest
      class Resource < Base
        attr_reader :client, :method, :path, :body
        attr_accessor :query, :pagination

        def initialize(config:, method:, path:, body: nil, query: nil)
          @client = Clients::Rest::Client.new(config:)
          @method = method
          @path = path
          @body = body
          @query = query

          validate
        end

        def call
          response = client.public_send(method, path:, body:, query:)

          pagination = Pagination.new(resource: self, page_info: response.page_info)
          @pagination = pagination if pagination.page_exists?

          ResourceResponse.new(body: response.body, headers: response.headers)
        end

        private

        def validate
          if [:put, :post].include?(method)
            raise Errors::ResourceError, "Argument 'body' is required for method: #{method}" if body.nil?
          end
        end
      end
    end
  end
end
