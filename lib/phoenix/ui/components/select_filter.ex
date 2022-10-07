defmodule Phoenix.UI.Components.SelectFilter do
  @moduledoc """
  Provides select filter component.
  """
  import Phoenix.UI.Components.Select

  use Phoenix.LiveComponent

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.form
        :let={f}
        class="flex-1"
        for={:filter}
        id={"#{@id}_form"}
        phx-change="handle_filter"
        phx-submit="handle_filter"
        phx-target={@myself}
      >
        <.select field={:select} form={f} phx-debounce={nil} {@select_attrs} />
      </.form>
    </div>
    """
  end

  @impl true
  def update(assigns, socket) do
    attrs = assigns_to_attributes(assigns, [:id, :on_clear, :on_filter])

    {:ok, socket |> assign(assigns) |> assign(:select_attrs, attrs)}
  end

  @impl true
  def handle_event("handle_clear", _params, socket) do
    socket.assigns.on_clear.(socket)
  end

  def handle_event("handle_filter", %{"filter" => %{"select" => value}}, socket) do
    socket.assigns.on_filter.(value, socket)
  end
end
