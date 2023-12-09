# frozen_string_literal: true

module ShopifyApiBruv
  module Clients
    class HttpResponse
      attr_reader :code, :headers, :body, :page_info

      def initialize(code:, headers:, body:)
        @code = code
        @headers = headers
        @body = body
        @page_info = parse_page_info

        ShopifyApiBruv.logger(
          method: :info,
          message: "Shopify API Response (Code: #{code}):\nHeaders:\n#{headers}\n\nBody:\n#{body}"
        )

        validate!
      end

      private

      def parse_page_info
        return { previous: nil, next: nil } if headers['link'].nil?

        page_info = {}

        headers['link'].split(',').each do |link|
          rel = link.match(/rel="(.*?)"/).captures.first
          url = link.match(/<(.*?)>/).captures.first

          URI.parse(url).query.split('&').each do |param|
            if param.split('=').first == 'page_info'
              page_info[rel] = param.split('=').last
              break
            end
          end
        end

        { previous: page_info['previous'], next: page_info['next'] }
      end

      def ok?
        (200..299).cover?(code)
      end

      def validate!
        return if ok?

        raise Errors::HttpResponseError, self
      end
    end
  end
end
