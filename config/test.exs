import Config

config :zen_ex,
  subdomain: "testdomain",
  user: "testuser@testdomain.zendesk.com",
  api_token: "testapitoken"

config :tesla, adapter: Tesla.Mock
