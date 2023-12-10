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
      response = resource.call

      expect(
        response
      ).not_to(be(nil))
    end
  end

  describe 'mutation' do
    let(:query) do
      <<~GRAPHQL
        mutation productCreate($input: ProductInput!) {
          productCreate(input: $input) {
            product {
              title
            }
            userErrors {
              field
              message
            }
          }
        }
      GRAPHQL
    end

    let(:variables) { { input: { title: 'Test product' } } }

    it 'successfully creates a product and returns product data' do
      resource.query = query
      resource.variables = variables

      expect(
        resource.call
      ).not_to(be(nil))
    end
  end
end
