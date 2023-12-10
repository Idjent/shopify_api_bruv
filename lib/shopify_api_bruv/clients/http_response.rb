# frozen_string_literal: true

module ShopifyApiBruv
  module Clients
    class HttpResponse
      attr_reader :code, :headers, :body

      def initialize(code:, headers:, body:)
        @code = code
        @headers = headers
        @body = body

        validate

        ShopifyApiBruv.logger(
          method: :info,
          message: "Shopify API Response (Code: #{code}):\nHeaders:\n#{headers}\n\nBody:\n#{body}"
        )
      end

      private

      def ok?
        (200..299).cover?(code)
      end

      def validate
        return if ok?

        errors = body['errors'] || ''

        raise Errors::HttpResponseError, errors
      end
    end
  end
end
