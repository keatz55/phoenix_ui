defmodule PhoenixUI.Components.Menu do
  @moduledoc """
  Provides menu component.
  """
  import PhoenixUI.Components.{Element, Paper}

  use PhoenixUI, :component

  @default_menu_element "ul"
  @default_menu_item_element "li"

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
  def menu(raw) do
    assigns =
      raw
      |> assign_new(:element, fn -> @default_menu_element end)
      |> build_menu_attrs()

    ~H"""
    <.paper {@menu_attrs}>
      <%= render_slot(@inner_block) %>
    </.paper>
    """
  end

  @doc """
  Renders menu_item component.

  ## Examples

      ```
      <.menu_item>Item #1</.menu_item>
      ```

  """
  @spec menu_item(Socket.assigns()) :: Rendered.t()
  def menu_item(raw) do
    assigns =
      raw
      |> assign_new(:element, fn -> @default_menu_item_element end)
      |> build_menu_item_attrs()

    ~H"""
    <.element {@menu_item_attrs}>
      <%= render_slot(@inner_block) %>
    </.element>
    """
  end

  ### Menu Attrs ##########################

  defp build_menu_attrs(assigns) do
    extend_class = build_class(~w(
      menu py-1
      #{Map.get(assigns, :extend_class)}
    ))

    attrs =
      assigns
      |> assigns_to_attributes([:extend_class])
      |> Keyword.put(:extend_class, extend_class)

    assign(assigns, :menu_attrs, attrs)
  end

  ### Menu Item Attrs ##########################

  defp build_menu_item_attrs(assigns) do
    class = build_class(~w(
      menu-item block w-full whitespace-nowrap
      #{classes(:menu_item, :color, assigns)}
      #{classes(:menu_item, :font, assigns)}
      #{classes(:menu_item, :spacing, assigns)}
      #{Map.get(assigns, :extend_class)}
    ))

    attrs =
      assigns
      |> assigns_to_attributes([:element, :extend_class])
      |> Keyword.put(:variant, assigns[:element])
      |> Keyword.put_new(:extend_class, class)

    assign(assigns, :menu_item_attrs, attrs)
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

  defp classes(_element, _rule_group, _assigns), do: nil
end
