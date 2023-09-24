defmodule BytebinderWeb.NailWatchLive.Index do
  use BytebinderWeb, :live_view

  alias Bytebinder.Notebook
  alias Bytebinder.Notebook.NailWatch

  on_mount {BytebinderWeb.UserAuth, :mount_current_user}

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :nail_watch_collection, Notebook.list_nail_watch())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Nail watch")
    |> assign(:nail_watch, Notebook.get_nail_watch!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Nail watch")
    |> assign(:nail_watch, %NailWatch{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Nail watch")
    |> assign(:nail_watch, nil)
  end

  @impl true
  def handle_info({BytebinderWeb.NailWatchLive.FormComponent, {:saved, nail_watch}}, socket) do
    {:noreply, stream_insert(socket, :nail_watch_collection, nail_watch)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    nail_watch = Notebook.get_nail_watch!(id)
    {:ok, _} = Notebook.delete_nail_watch(nail_watch)

    {:noreply, stream_delete(socket, :nail_watch_collection, nail_watch)}
  end
end
