# Documentation

## Auth
```ruby
# Initialize a config
config = ShopifyApiBruv::Auth::Config.new(
  api_domain: "shop.myshopify.com",
  api_version: "2023-10",
  api_access_token: "ACCESS_TOKEN"
)
```

## Usage (GraphQL)  

### Simple request

```ruby
# Initialize a graphql client and provide the config
client = ShopifyApiBruv::Clients::Graphql::Client.new(config:)

# Define a query
query = <<~GRAPHQL
  query {
    products(first: 250) {
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

# Make the request
client.request(query:)
```

### Using the resource class

```ruby
class GetProducts < ShopifyApiBruv::Resources::Graphql::Resource
  def query
    <<~GRAPHQL
      query {
        products(first: 250) {
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
end

# Usage
GetProducts.request(config:)
```

## Usage (Rest)  

### Simple request

```ruby
# Initialize a graphql client and provide the config
client = ShopifyApiBruv::Clients::Rest::Client.new(config:)

# Make the request
client.get(path: '/products')
```

### Using the resource class

```ruby
class GetProducts < ShopifyApiBruv::Resources::Rest::Resource
  def initialize(config:)
    super(
      config:,
      method: :get,
      path: '/products'
    )
  end
end

# Usage
GetProducts.request(config:)
```