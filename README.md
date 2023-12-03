# Speak

## Setting up project

- Run `mix setup` to install and setup dependencies
- Copy contenst of `.env.template` to `.env` and setup the appropriate values
- Run `mix ecto.create` to run the first setup for the database. This will create the project database if it doesn't exist
- Now run `mix ecto.migrate` to run the migrations to have all tables and entities setup
- Now you can start your phoenix server as described below.
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
Https connection is also available [`localhost:4001`](http://localhost:4001)

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
