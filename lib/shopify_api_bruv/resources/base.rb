# frozen_string_literal: true

module ShopifyApiBruv
  module Resources
    class Base
      def self.call(...)
        new(...).call
      end
    end
  end
end
