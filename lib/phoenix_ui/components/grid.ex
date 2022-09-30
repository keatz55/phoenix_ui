defmodule PhoenixUI.Components.Grid do
  @moduledoc """
  Provides grid component.
  """
  use PhoenixUI, :component

  attr(:columns, :integer, default: 12)
  attr(:element, :string, default: "div")

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
  def grid(prev_assigns) do
    assigns = build_grid_attrs(prev_assigns)

    ~H"""
    <.dynamic_tag {@grid_attrs}>
      <%= render_slot(@inner_block) %>
    </.dynamic_tag>
    """
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
      |> Keyword.put(:name, assigns[:element])

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
