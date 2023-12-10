# frozen_string_literal: true

module ShopifyApiBruv
  module Resources
    module Rest
      class Pagination
        attr_reader :resource, :page_info

        def initialize(resource:, page_info:)
          @resource = resource
          @page_info = page_info
        end

        def next_page?
          !page_info[:next].nil?
        end

        def previous_page?
          !page_info[:previous].nil?
        end

        def purpose?
          next_page? || previous_page?
        end

        def fetch_next_page
          raise Errors::ResourceError, 'Next page cursor not found' unless next_page?

          resource.query[:page_info] = page_info[:next]
          resource.call
        end

        def fetch_previous_page
          raise Errors::ResourceError, 'Previous page cursor not found' unless previous_page?

          resource.query[:page_info] = page_info[:previous]
          resource.call
        end
      end
    end
  end
end
