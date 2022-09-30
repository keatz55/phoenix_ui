defmodule PhoenixUI.Components.Divider do
  @moduledoc """
  Provides divider component.
  """
  use PhoenixUI, :component

  @default_color "slate"
  @default_variant "full_width"

  @doc """
  Renders divider component.

  ## Examples

      ```
      <.divider />
      ```

  """
  @spec divider(Socket.assigns()) :: Rendered.t()
  def divider(raw) do
    assigns =
      raw
      |> assign_new(:color, fn -> @default_color end)
      |> assign_new(:variant, fn -> @default_variant end)
      |> build_divider_attrs()

    ~H"""
    <hr {@divider_attrs} />
    """
  end

  ### Divider Attrs ##########################

  defp build_divider_attrs(assigns) do
    class = build_class(~w(
      divider
      #{classes(:color, assigns)}
      #{classes(:variant, assigns)}
      #{Map.get(assigns, :extend_class)}
    ))

    attrs =
      assigns
      |> assigns_to_attributes([:color, :variant])
      |> Keyword.put_new(:class, class)

    assign(assigns, :divider_attrs, attrs)
  end

  ### CSS Classes ##########################

  # Color
  defp classes(:color, %{color: color}), do: "border-#{color}-200 dark:border-#{color}-500"

  # Variant
  defp classes(:variant, %{variant: "inset"}), do: "ml-4"
  defp classes(:variant, %{variant: "middle"}), do: "mx-4"

  defp classes(_rule_group, _assigns), do: nil
end
