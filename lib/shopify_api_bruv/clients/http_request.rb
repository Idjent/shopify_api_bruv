# frozen_string_literal: true

module ShopifyApiBruv
  module Clients
    class HttpRequest
      attr_reader :api, :method, :path, :body, :content_type, :query, :headers

      VALID_METHODS = [
        :get,
        :delete,
        :put,
        :post
      ].freeze

      def initialize(api:, method:, path:, body:, content_type:, query: nil, headers:)
        @api = api
        @method = method
        @path = path
        @body = body.is_a?(Hash) ? body.to_json : body
        @content_type = content_type
        @query = query
        @headers = headers

        validate

        ShopifyApiBruv.logger(
          method: :info,
          message: "Shopify API Request (Method: #{method}):\nPath:\n#{path}\n\nBody:\n#{body}"
        )
      end

      private

      def validate
        raise Errors::HttpRequestError,
          "Invalid method #{method}, valid methods are: #{VALID_METHODS}" unless VALID_METHODS.include?(method)

        raise Errors::HttpRequestError,
          'Content-Type missing' if !body.nil? && content_type.nil?

        return unless [:put, :post].include?(method)

        raise Errors::HttpRequestError, "Body is required for method #{method}" if body.nil?
      end
    end
  end
end
