# frozen_string_literal: true

module ShopifyApiBruv
  module Resources
    module Graphql
      class ResourceResponse
        attr_accessor :data, :extensions, :throttle_status

        def initialize(body:, query:)
          parse_body(body:, query:)
        end

        def as_open_struct
          # rubocop:disable Style/OpenStructUse
          JSON.parse(data.to_json, object_class: OpenStruct)
          # rubocop:enable Style/OpenStructUse
        end

        private

        def parse_body(body:, query:)
          mutation_object_name = query.match(/mutation\s+(\w+)\s*\(.*/)&.captures&.first

          @data = mutation_object_name.nil? ? body['data'] : body.dig('data', mutation_object_name)
          @throttle_status = body.dig('extensions', 'cost', 'throttleStatus')
        end
      end
    end
  end
end
