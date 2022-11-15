defmodule Phoenix.UI.Components.Menu do
  @moduledoc """
  Provides menu component.
  """
  import Phoenix.UI.Components.Paper

  use Phoenix.UI, :component

  attr(:element, :string, default: "ul")
  attr(:extend_class, :string)

  slot(:inner_block, required: true)

  @doc """
  Renders menu component.

  ## Examples

      ```
      <.menu>
        <.menu_item>Item #1</.menu_item>
        ...
      </.menu>
      ```

  """
  @spec menu(Socket.assigns()) :: Rendered.t()
  def menu(prev_assigns) do
    assigns =
      prev_assigns
      |> assign_extend_class(~w(menu py-1))
      |> assign_rest()

    ~H"""
    <.paper extend_class={@extend_class} {@rest}>
      <%= render_slot(@inner_block) %>
    </.paper>
    """
  end

  attr(:element, :string, default: "li")

  slot(:inner_block, required: true)

  @doc """
  Renders menu_item component.

  ## Examples

      ```
      <.menu_item>Item #1</.menu_item>
      ```

  """
  @spec menu_item(Socket.assigns()) :: Rendered.t()
  def menu_item(prev_assigns) do
    assigns =
      prev_assigns
      |> assign_class(~w(
        menu-item block w-full whitespace-nowrap
        #{classes(:menu_item, :color, prev_assigns)}
        #{classes(:menu_item, :font, prev_assigns)}
        #{classes(:menu_item, :spacing, prev_assigns)}
      ))
      |> assign_rest()

    ~H"""
    <.dynamic_tag name={@element} class={@class} {@rest}>
      <%= render_slot(@inner_block) %>
    </.dynamic_tag>
    """
  end

  ### CSS Classes ##########################

  # Menu Item - Color
  defp classes(:menu_item, :color, _assigns) do
    "text-slate-700 dark:text-slate-300 hover:bg-slate-100 dark:hover:bg-slate-100/25"
  end

  # Menu Item - Font
  defp classes(:menu_item, :font, _assigns), do: "text-sm font-normal"

  # Menu Item - Spacing
  defp classes(:menu_item, :spacing, _assigns), do: "py-2 px-4"
end
