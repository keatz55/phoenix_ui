defmodule PhoenixUI.Components.Grid do
  @moduledoc """
  Provides a container component.

  ## Import

  ```elixir
  alias PhoenixUI.Components.Container
  # or
  alias PhoenixUI.Components.{
    ...
    Container
  }
  ```

  ## Variants

  - fixed
  - fluid

  ## Supported Assigns

  - elevation - keyword list of options you would normally pass to a `live_redirect` function
  - square - true or false
  - All HTML div attributes
  - All Phoenix LiveView bindings
  """
  import PhoenixUI.Components.Element

  use Phoenix.Component

  @default_columns 12
  @default_element "div"

  @doc """
  Renders container component

  ## Examples

      ```
      <.container>
        Content
      </.container>
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

  defp build_grid_attrs(assigns) do
    framework = PhoenixUI.Theme.css_framework()

    class =
      ~w(
        #{column_spacing_css(framework, assigns)}
        #{columns_css(framework, assigns)}
        #{default_css(framework, assigns)}
        #{row_spacing_css(framework, assigns)}
        #{Map.get(assigns, :extend_class)}
      )
      |> Enum.join(" ")
      |> String.trim()

    attrs =
      assigns
      |> Map.drop([
        :__changed__,
        :__slot__,
        :columns,
        :element,
        :extend_class,
        :inner_block,
        :spacing
      ])
      |> Map.put_new(:class, class)
      |> Map.put(:variant, assigns[:element])

    assign(assigns, :grid_attrs, attrs)
  end

  # Column Spacing CSS
  defp column_spacing_css(:tailwind, %{column_spacing: val}), do: "gap-y-#{val}"
  defp column_spacing_css(:tailwind, %{spacing: val}), do: "gap-y-#{val}"
  defp column_spacing_css(_css_framework, _assigns), do: nil

  # Columns CSS
  defp columns_css(:tailwind, %{columns: val}), do: "grid-cols-#{val}"
  defp columns_css(_css_framework, _assigns), do: nil

  # Default CSS
  defp default_css(:tailwind, _assigns), do: "grid"
  defp default_css(_css_framework, _assigns), do: nil

  # Row Spacing CSS
  defp row_spacing_css(:tailwind, %{row_spacing: val}), do: "gap-x-#{val}"
  defp row_spacing_css(:tailwind, %{spacing: val}), do: "gap-x-#{val}"
  defp row_spacing_css(_css_framework, _assigns), do: nil
end
