defmodule BytebinderWeb.NailWatchLive.Show do
  use BytebinderWeb, :live_view

  alias Bytebinder.Notebook

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:nail_watch, Notebook.get_nail_watch!(id))}
  end

  defp page_title(:show), do: "Show Nail watch"
  defp page_title(:edit), do: "Edit Nail watch"
end
