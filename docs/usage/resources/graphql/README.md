# GraphQL

You can either use the resource class directly:

```ruby
resource = ShopifyApiBruv::Resources::Graphql::Resource.new(config:)
resource.query = <<~GRAPHQL
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
resource.variables = { input: { title: "Test Product" } }
resource.call
```


Or define it as a class inheriting from `ShopifyApiBruv::Resources::Graphql::Resource`

## Query

```ruby
# frozen_string_literal: true

module Shopify
  module Graphql
    class GetProduct < ShopifyApiBruv::Resources::Graphql::Resource
      QUERY = <<~GRAPHQL
        query ($id: ID!) {
          product(id: $id) {
            id
            title
          }
        }
      GRAPHQL
    end
  end
end
```

Usage:

```ruby
Shopify::Graphql::GetProduct.call(config:, variables: { id: "gid://shopify/Product/1234567890" })
```

## Mutation

```ruby
# frozen_string_literal: true

module Shopify
  module Graphql
    class CreateProduct < ShopifyApiBruv::Resources::Graphql::Resource
      QUERY = <<~GRAPHQL
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
  end
end
```

Usage:

```ruby
Shopify::Graphql::CreateProduct.call(config:, variables: { input: { title: "Test Product" } })
```
