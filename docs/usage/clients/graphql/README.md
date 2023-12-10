# GraphQL

```ruby
# Initialize a graphql client
client = ShopifyApiBruv::Clients::Graphql::Client.new(config:)

# Define your query
query = <<~GRAPHQL
  query {
    products(first: 10) {
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
