# frozen_string_literal: true

module ShopifyApiBruv
  module Resources
    module Rest
      class Object
        attr_accessor :data

        def initialize(body:)
          @data = body
        end

        def as_open_struct
          # rubocop:disable Style/OpenStructUse
          JSON.parse(data.to_json, object_class: OpenStruct)
          # rubocop:enable Style/OpenStructUse
        end
      end
    end
  end
end
