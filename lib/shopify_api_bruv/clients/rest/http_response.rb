# frozen_string_literal: true

module ShopifyApiBruv
  module Clients
    module Rest
      class HttpResponse < HttpResponse
        attr_reader :page_info

        def initialize(code:, headers:, body:)
          super(code:, headers:, body:)

          @page_info = parse_page_info
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
      end
    end
  end
end
