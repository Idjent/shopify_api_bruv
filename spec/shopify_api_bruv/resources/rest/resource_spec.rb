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
      path: '/products',
      query: { limit: 1 }
    )
  end

  describe '.get' do
    it 'successfully returns product data' do
      response_result = resource.call

      expect(
        response_result
      ).not_to(be(nil))
    end

    it 'successfully returns paginated product data' do
      response_result = resource.call

      if resource&.pagination&.next_page?
        response_result.data['products'].concat(resource.pagination.fetch_next_page.data['products'])
      end

      expect(
        response_result.data['products'].size >= 1
      ).not_to(be(nil))
    end
  end
end
