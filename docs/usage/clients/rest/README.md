# Rest

```ruby
# Initialize a rest client
client = ShopifyApiBruv::Clients::Rest::Client.new(config:)

# Make the request
client.get(path: '/products', query: { limit: 10 })
```
