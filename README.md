# CodeBeam

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Get Marvel API credentials from [here](https://www.google.com/search?client=safari&rls=en&q=marvel+api+account&ie=UTF-8&oe=UTF-8)
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`
  * Create a `dev.secret.exs` file and add the following:
  ```
use Mix.Config

config :code_beam,
  marvel_public_key: "marvel-public-key",
  marvel_private_key: "marvel-private-key"

  ```

  * Run the server
  * Test the server with `curl localhost:4000/?q=Hulk`