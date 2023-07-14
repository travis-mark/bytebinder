# Bytebinder

A sandbox for learning Elixir / Phoenix

## Operations

Local: 
* Run `mix setup` to install and setup dependencies
* Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Dev Server:
* Run `mix phx.gen.release`
* Run `flyctl deploy`

## Upcoming
* https://hexdocs.pm/phoenix/components.html - Start using .input / .table
* https://hexdocs.pm/phoenix/ecto.html - Add gravestone to User schema

## Questions

The standard resource set includes:
* GET /resource => :index
* GET /resource/new => :new
* POST /resource => :create
* GET /resource/:id => :show
* GET /resource/:id/edit => :edit
* PATCH /resource/:id => :update
* PUT /resource/:id => :update
* DELETE /resource/:id => :delete

:new => :create and :edit => update make obvious pairs. 
1. Where is ??? => :delete, since that would likely include the delete confirmation? 
2. Where is the PATCH / PUT determination made? (.form appears to use PUT)

## Reference (leave this intact for now)
  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
