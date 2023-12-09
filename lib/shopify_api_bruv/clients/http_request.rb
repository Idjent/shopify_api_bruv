# frozen_string_literal: true

module ShopifyApiBruv
  module Clients
    class HttpRequest
      attr_reader :method, :path, :body, :content_type, :query, :headers

      def initialize(method:, path:, body:, content_type:, query: nil, headers:)
        @method = method
        @path = path
        @body = body.is_a?(Hash) ? body.to_json : body
        @content_type = content_type
        @query = query
        @headers = headers

        ShopifyApiBruv.logger(
          method: :info,
          message: "Shopify API Request (Method: #{method}):\nPath:\n#{path}\n\nBody:\n#{body}"
        )
      end
    end
  end
end
