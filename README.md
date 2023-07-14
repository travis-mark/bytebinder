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
  * https://hexdocs.pm/phoenix/controllers.html

## Questions
  * The standard resource set includes:
    * GET /resource => :index
    * GET /resource/new => :new
    * POST /resource => :create
    * GET /resource/:id => :show
    * GET /resource/:id/edit => :edit
    * PATCH /resource/:id => :update
    * PUT /resource/:id => :update
    * DELETE /resource/:id => :delete
    :new => :create and :edit => update make obvious pairs. 
    * Where is ??? => :delete, since that would likely include the delete confirmation? 
    * Where is the PATCH / PUT determination made? (.form appears to use PUT)
  


## Reference (leave this intact for now)
  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
