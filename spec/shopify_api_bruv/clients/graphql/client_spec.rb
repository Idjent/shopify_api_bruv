# frozen_string_literal: true

RSpec.describe(ShopifyApiBruv::Clients::Graphql::Client) do
  let(:config) do
    ShopifyApiBruv::Auth::Config.new(
      api_domain: ENV.fetch('API_DOMAIN', nil),
      api_version: ENV.fetch('API_VERSION', nil),
      api_access_token: ENV.fetch('API_ACCESS_TOKEN', nil)
    )
  end

  let(:client) { ShopifyApiBruv::Clients::Graphql::Client.new(config:) }

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
      expect(
        client.request(query:)
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
      expect(
        client.request(query:, variables:)
      ).not_to(be(nil))
    end
  end
end
