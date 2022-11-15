defmodule Phoenix.UI.Components.Grid do
  @moduledoc """
  Provides grid component.
  """
  use Phoenix.UI, :component

  attr(:columns, :integer, default: 12)
  attr(:element, :string, default: "div")
  attr(:extend_class, :string)
  attr(:rest, :global)

  slot(:inner_block, required: true)

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
    assigns = assign_class(prev_assigns, ~w(
        grid
        #{classes(:column_spacing, prev_assigns)}
        #{classes(:columns, prev_assigns)}
        #{classes(:row_spacing, prev_assigns)}
      ))

    ~H"""
    <.dynamic_tag class={@class} name={@element} {@grid_attrs}>
      <%= render_slot(@inner_block) %>
    </.dynamic_tag>
    """
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
