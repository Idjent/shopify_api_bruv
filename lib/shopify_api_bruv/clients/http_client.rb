# frozen_string_literal: true

module ShopifyApiBruv
  module Clients
    class HttpClient
      attr_reader :config, :endpoint, :headers

      def initialize(config:, path:)
        raise Errors::HttpClientError, 'Missing or invalid config.' unless config.is_a?(Auth::Config)

        @config = config
        @endpoint = "#{config.api_domain}/#{path}"
        @headers = {
          'User-Agent': "Bruv #{VERSION}",
          'Accept': 'application/json',
          'X-Shopify-Access-Token': config.api_access_token
        }
      end

      def request(http_request:)
        raise Errors::HttpClientError, 'Missing or invalid http request.' unless http_request.is_a?(HttpRequest)

        headers.merge(http_request.headers) unless http_request.headers.nil?
        headers['Content-Type'] = http_request.content_type

        response = HTTParty.public_send(
          http_request.method,
          "https://#{endpoint}/#{http_request.path}",
          headers:,
          query: http_request.query,
          body: http_request.body
        )

        HttpResponse.new(code: response.code, headers: response.headers, body: response.parsed_response)
      end
    end
  end
end
