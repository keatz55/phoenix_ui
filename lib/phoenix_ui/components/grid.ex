defmodule PhoenixUI.Components.Grid do
  @moduledoc """
  Provides grid component.
  """
  import PhoenixUI.Components.Element

  use PhoenixUI, :component

  @default_columns 12
  @default_element "div"

  @doc """
  Renders grid component.

  ## Examples

      ```
      <.grid>
        Content
      </.grid>
      ```

  """
  @spec grid(Socket.assigns()) :: Rendered.t()
  def grid(raw_assigns) do
    assigns =
      raw_assigns
      |> assign_new(:columns, fn -> @default_columns end)
      |> assign_new(:element, fn -> @default_element end)
      |> build_grid_attrs()

    ~H"""
    <.element {@grid_attrs}>
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
    generate_all_classes(&grid/1,
      column_spacing: 1..12,
      columns: 1..12,
      row_spacing: 1..12,
      spacing: 1..12
    )
  end

  ### Grid Attrs ##########################

  defp build_grid_attrs(assigns) do
    class = build_class(~w(
      grid
      #{classes(:column_spacing, assigns)}
      #{classes(:columns, assigns)}
      #{classes(:row_spacing, assigns)}
      #{Map.get(assigns, :extend_class)}
    ))

    attrs =
      assigns
      |> assigns_to_attributes([:columns, :element, :extend_class, :spacing])
      |> Keyword.put_new(:class, class)
      |> Keyword.put(:variant, assigns[:element])

    assign(assigns, :grid_attrs, attrs)
  end

  ### CSS Classes ##########################

  # Column Spacing
  defp classes(:column_spacing, %{column_spacing: val}), do: "gap-y-#{val}"
  defp classes(:column_spacing, %{spacing: val}), do: "gap-y-#{val}"

  # Columns
  defp classes(:columns, %{columns: val}), do: "grid-cols-#{val}"

  # Row Spacing
  defp classes(:row_spacing, %{row_spacing: val}), do: "gap-x-#{val}"
  defp classes(:row_spacing, %{spacing: val}), do: "gap-x-#{val}"

  defp classes(_rule_group, _assigns), do: nil
end
