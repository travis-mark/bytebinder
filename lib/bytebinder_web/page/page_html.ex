defmodule BytebinderWeb.PageHTML do
  use BytebinderWeb, :html

  embed_templates "*"

  attr :href, :string, default: nil
  slot :inner_block, required: true
  def app_button(assigns) do
    ~H"""
      <a href={@href}>
        <div class="w-32 h-32 flex flex-col justify-center items-center bg-gray-400 hover:bg-gray-200 rounded-lg">
          <%= render_slot(@inner_block) %>
        </div>
      </a>
    """
  end
end
