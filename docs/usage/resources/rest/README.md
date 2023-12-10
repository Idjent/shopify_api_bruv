# Rest

You can either use the resource class directly:

```ruby
resource = ShopifyApiBruv::Resources::Rest::Resource.new(
  config:,
  method: :get,
  path: '/products',
  query: { limit: 10 }
)
response = resource.call

# Built in pagination example
loop do
  break if resource.pagination.nil? && !resource.pagination.next_page?
  response = resource.pagination.fetch_next_page
end
```

Or define it as a class inheriting from `ShopifyApiBruv::Resources::Rest::Resource`

## Receive data

```ruby
# frozen_string_literal: true

module Shopify
  module Rest
    class GetProduct < ShopifyApiBruv::Resources::Rest::Resource
      def initialize(config:, id:)
        super(
          config:,
          method: :get,
          path: "/products/#{id}"
        )
      end
    end
  end
end
```

Usage:

```ruby
Shopify::Rest::GetProduct.call(config:, id: "1234567890")
```

## Populate data

```ruby
# frozen_string_literal: true

module Shopify
  module Rest
    class CreateProduct < ShopifyApiBruv::Resources::Rest::Resource
      def initialize(config:, body:)
        super(
          config:,
          method: :post,
          path: '/products',
          body:
        )
      end
    end
  end
end
```

Usage:

```ruby
Shopify::Rest::CreateProduct.call(config:, body: { product: { title: "Test Product" }  })
```
