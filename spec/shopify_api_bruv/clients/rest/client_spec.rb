# frozen_string_literal: true

RSpec.describe(ShopifyApiBruv::Clients::Rest::Client) do
  let(:config) do
    ShopifyApiBruv::Auth::Config.new(
      api_domain: ENV.fetch('API_DOMAIN', nil),
      api_version: ENV.fetch('API_VERSION', nil),
      api_access_token: ENV.fetch('API_ACCESS_TOKEN', nil)
    )
  end

  let(:client) { ShopifyApiBruv::Clients::Rest::Client.new(config:) }

  describe '.get' do
    it 'successfully returns product data' do
      expect(
        client.get(path: '/products?limit=1')
      ).not_to(be(nil))
    end
  end
end
