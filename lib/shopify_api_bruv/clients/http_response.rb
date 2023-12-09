# frozen_string_literal: true

module ShopifyApiBruv
  module Clients
    class HttpResponse
      attr_reader :code, :headers, :body

      def initialize(code:, headers:, body:)
        @code = code
        @headers = headers
        @body = body

        ShopifyApiBruv.logger(
          method: :info,
          message: "Shopify API Response (Code: #{code}):\nHeaders:\n#{headers}\n\nBody:\n#{body}"
        )
      end
    end
  end
end
