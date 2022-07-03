defmodule PhoenixUI.Components.Dropdown do
  import PhoenixUI.Components.Menu

  use PhoenixUI, :component

  @default_variant "elevated"

  @spec dropdown(Socket.assigns()) :: Rendered.t()
  def dropdown(raw_assigns) do
    assigns = assign_new(raw_assigns, :variant, fn -> @default_variant end)

    ~H"""
    <div
      id={@id}
      class="relative dropdown"
      phx-click-away={close_dropdown(@id)}>
      <div
        class="flex items-baseline cursor-pointer gap-x-1 dropdown-toggle"
        phx-click={toggle_dropdown(@id)}>
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

  def close_dropdown(id), do: JS.hide(%JS{}, to: "##{id} .dropdown-menu")

  def toggle_dropdown(id), do: JS.toggle(%JS{}, to: "##{id} .dropdown-menu")
end
