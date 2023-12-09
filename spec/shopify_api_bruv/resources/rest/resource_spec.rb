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
      response_result = resource.request

      expect(
        response_result
      ).not_to(be(nil))
    end

    it 'successfully returns paginated product data' do
      response_result = resource.request

      if !resource.pagination_resource.nil? && resource.pagination_resource.next_page?
        response_result['products'].concat(resource.pagination_resource.fetch_next_page['products'])
      end

      expect(
        response_result['products'].size >= 1
      ).not_to(be(nil))
    end
  end
end
