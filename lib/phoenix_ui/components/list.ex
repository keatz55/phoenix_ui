defmodule PhoenixUI.Components.List do
  @moduledoc """
  Provides list component.
  """
  import PhoenixUI.Components.Element

  use PhoenixUI, :component

  @default_list_element "ul"
  @default_list_item_element "li"

  @doc """
  Renders list component.

  ## Examples

      ```
      <.list>
        <.list_item>Item #1</.list_item>
        ...
      </.list>
      ```

  """
  @spec list(Socket.assigns()) :: Rendered.t()
  def list(raw_assigns) do
    assigns =
      raw_assigns
      |> assign_new(:element, fn -> @default_list_element end)
      |> build_list_attrs()

    ~H"""
    <.element {@list_attrs}>
      <%= render_slot(@inner_block) %>
    </.element>
    """
  end

  @doc """
  Renders list item component.

  ## Examples

      ```
      <.list>
        <.list_item>Item #1</.list_item>
        ...
      </.list>
      ```

  """
  @spec list_item(Socket.assigns()) :: Rendered.t()
  def list_item(raw_assigns) do
    assigns =
      raw_assigns
      |> assign_new(:element, fn -> @default_list_item_element end)
      |> build_list_item_attrs()

    ~H"""
    <.element {@list_item_attrs}>
      <%= render_slot(@inner_block) %>
    </.element>
    """
  end

  @doc """
  Returns all possible component classes for Tailwind CSS JIT compilation.

  ## Examples

      iex> classes()
      ["class1", "class2", ...]

  """
  @spec classes :: [String.t()]
  def classes do
    [
      generate_all_classes(&list/1, []),
      generate_all_classes(&list_item/1, [])
    ]
    |> List.flatten()
    |> Enum.uniq()
  end

  ### List Attrs ##########################

  defp build_list_attrs(assigns) do
    extend_class = build_class(~w(
      py-1
      #{Map.get(assigns, :extend_class)}
    ))

    attrs =
      assigns
      |> assigns_to_attributes([:extend_class])
      |> Keyword.put(:variant, assigns[:element])
      |> Keyword.put(:extend_class, extend_class)

    assign(assigns, :list_attrs, attrs)
  end

  ### List Item Attrs ##########################

  defp build_list_item_attrs(assigns) do
    class = build_class(~w(
      block w-full whitespace-nowrap py-2 px-4 text-sm font-normal
      text-slate-700 dark:text-slate-300 hover:bg-slate-100 dark:hover:bg-slate-100/25
      #{Map.get(assigns, :extend_class)}
    ))

    attrs =
      assigns
      |> assigns_to_attributes([:element, :extend_class])
      |> Keyword.put(:variant, assigns[:element])
      |> Keyword.put_new(:extend_class, class)

    assign(assigns, :list_item_attrs, attrs)
  end
end
