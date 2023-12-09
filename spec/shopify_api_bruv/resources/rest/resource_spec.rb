# frozen_string_literal: true

RSpec.describe(ShopifyApiBruv::Resources::Rest::Resource) do
  let(:config) do
    ShopifyApiBruv::Auth::Config.new(
      api_domain: ENV.fetch('API_DOMAIN', nil),
      api_version: ENV.fetch('API_VERSION', nil),
      api_access_token: ENV.fetch('API_ACCESS_TOKEN', nil)
    )
  end

  let(:resource) do
    ShopifyApiBruv::Resources::Rest::Resource.new(
      config:,
      method: :get,
      path: '/products'
    )
  end

  describe '.get' do
    it 'successfully returns product data' do
      expect(
        resource.request
      ).not_to(be(nil))
    end
  end
end
