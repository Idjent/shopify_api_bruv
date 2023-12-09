# frozen_string_literal: true

module ShopifyApiBruv
  module Resources
    class Base
      def self.request(...)
        new(...).request
      end
    end
  end
end
