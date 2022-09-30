defmodule Phoenix.UI.Components.Autocomplete do
  @moduledoc """
  Provides text filter component.
  """
  alias Phoenix.UI.Components.TextFilter

  import Phoenix.UI.Components.Menu

  use Phoenix.UI, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.live_component module={TextFilter} {@text_filter_attrs} />
      <.menu extend_class="mb-6">
        <%= for option <- @options do %>
          <.menu_item>
            <%= option %>
          </.menu_item>
        <% end %>
      </.menu>
    </div>
    """
  end

  @impl true
  def update(assigns, socket) do
    {
      :ok,
      socket
      |> assign(assigns)
      |> build_text_filter_attrs()
      |> apply_options()
    }
  end

  defp apply_options(socket) do
    socket.assigns[:set_options].(socket.assigns[:value], socket)
  end

  ### Text Filter Attrs ##########################

  defp build_text_filter_attrs(%Socket{assigns: assigns} = socket) do
    attrs =
      assigns
      |> assigns_to_attributes([:text_filter_attrs, :set_options])

    assign(socket, text_filter_attrs: attrs)
  end
end
