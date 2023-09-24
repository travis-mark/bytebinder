defmodule BytebinderWeb.NailWatchLive.FormComponent do
  use BytebinderWeb, :live_component

  alias Bytebinder.Notebook

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage nail_watch records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="nail_watch-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:date]} type="date" label="Date" />
        <.input field={@form[:nails]} type="number" label="Nails" />
        <.input field={@form[:skin]} type="number" label="Skin" />
        <.input field={@form[:blood]} type="number" label="Blood" />
        <.input field={@form[:flag]} type="text" label="Flag" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Nail watch</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{nail_watch: nail_watch} = assigns, socket) do
    changeset = Notebook.change_nail_watch(nail_watch)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"nail_watch" => nail_watch_params}, socket) do
    changeset =
      socket.assigns.nail_watch
      |> Notebook.change_nail_watch(nail_watch_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"nail_watch" => nail_watch_params}, socket) do
    save_nail_watch(socket, socket.assigns.action, nail_watch_params)
  end

  defp save_nail_watch(socket, :edit, nail_watch_params) do
    case Notebook.update_nail_watch(socket.assigns.nail_watch, nail_watch_params) do
      {:ok, nail_watch} ->
        notify_parent({:saved, nail_watch})

        {:noreply,
         socket
         |> put_flash(:info, "Nail watch updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_nail_watch(socket, :new, nail_watch_params) do
    case Notebook.create_nail_watch(nail_watch_params) do
      {:ok, nail_watch} ->
        notify_parent({:saved, nail_watch})

        {:noreply,
         socket
         |> put_flash(:info, "Nail watch created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
