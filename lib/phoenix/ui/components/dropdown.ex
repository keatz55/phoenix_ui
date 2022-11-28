defmodule Phoenix.UI.Components.Dropdown do
  @moduledoc """
  Provides dropdown component.
  """
  import Phoenix.UI.Components.Menu

  use Phoenix.UI, :component

  @default_variant "elevated"

  @doc """
  Renders dropdown component.

  ## Examples

      ```
      <.dropdown id="basic_dropdown">
        <:toggle>
          Toggle Dropdown
        </:toggle>
        content
      </.drawer>
      ```

  """
  @spec dropdown(Socket.assigns()) :: Rendered.t()
  def dropdown(raw_assigns) do
    assigns = assign_new(raw_assigns, :variant, fn -> @default_variant end)

    ~H"""
    <div id={@id} class="relative dropdown" phx-click-away={hide_dropdown(@id)}>
      <div
        class="flex items-baseline cursor-pointer gap-x-1 dropdown-toggle"
        phx-click={toggle_dropdown(@id)}
      >
        <%= render_slot(@toggle) %>
      </div>
      <.menu extend_class="dropdown-menu hidden absolute right-0 mt-2 z-20">
        <%= render_slot(@inner_block) %>
      </.menu>
    </div>
    """
  end

  #############################################################################################
  ### Actions
  #############################################################################################

  @doc """
  Closes dropdown matching selector.

  ## Examples

      iex> hide_drawer(selector)
      %JS{}

      iex> hide_drawer(js, selector)
      %JS{}

  """
  @spec hide_dropdown(String.t()) :: struct()
  def hide_dropdown(id), do: JS.hide(%JS{}, to: "##{id} .dropdown-menu")

  @doc """
  Toggles dropdown matching selector.

  ## Examples

      iex> hide_drawer(selector)
      %JS{}

      iex> hide_drawer(js, selector)
      %JS{}

  """
  @spec toggle_dropdown(String.t()) :: struct()
  def toggle_dropdown(id), do: JS.toggle(%JS{}, to: "##{id} .dropdown-menu")
end
