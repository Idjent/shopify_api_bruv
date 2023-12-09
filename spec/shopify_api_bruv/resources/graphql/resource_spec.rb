# frozen_string_literal: true

RSpec.describe(ShopifyApiBruv::Resources::Graphql::Resource) do
  let(:config) do
    ShopifyApiBruv::Auth::Config.new(
      api_domain: ENV.fetch('API_DOMAIN', nil),
      api_version: ENV.fetch('API_VERSION', nil),
      api_access_token: ENV.fetch('API_ACCESS_TOKEN', nil)
    )
  end

  let(:resource) { ShopifyApiBruv::Resources::Graphql::Resource.new(config:) }

  describe '.request' do
    let(:query) do
      <<~GRAPHQL
        query {
          products(first: 1) {
            edges {
              node {
                id
                title
                handle
              }
            }
          }
        }
      GRAPHQL
    end

    it 'successfully returns product data' do
      resource.query = query

      expect(
        resource.request
      ).not_to(be(nil))
    end
  end
end
