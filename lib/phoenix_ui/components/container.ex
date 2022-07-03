defmodule PhoenixUI.Components.Container do
  @moduledoc """
  Provides container component.
  """
  import PhoenixUI.Components.Element

  use PhoenixUI, :component

  @default_element "div"
  @default_max_width "screen-lg"
  @default_variant "fluid"

  @doc """
  Renders container component.

  ## Examples

      ```
      <.container>
        Content
      </.container>
      ```

  """
  @spec container(Socket.assigns()) :: Rendered.t()
  def container(raw_assigns) do
    assigns =
      raw_assigns
      |> assign_new(:element, fn -> @default_element end)
      |> assign_new(:max_width, fn -> @default_max_width end)
      |> assign_new(:variant, fn -> @default_variant end)
      |> build_container_attrs()

    ~H"""
    <.element {@container_attrs}>
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
    generate_all_classes(&container/1,
      max_width: Theme.max_widths(),
      variant: ["fixed", "fluid"]
    )
  end

  ### Container Attrs ##########################

  defp build_container_attrs(assigns) do
    class = build_class(~w(
      container mx-auto
      #{classes(:max_width, assigns)}
      #{classes(:variant, assigns)}
      #{Map.get(assigns, :extend_class)}
    ))

    attrs =
      assigns
      |> assigns_to_attributes([:element, :extend_class, :max_width, :variant])
      |> Keyword.put_new(:class, class)
      |> Keyword.put(:variant, assigns[:element])

    assign(assigns, :container_attrs, attrs)
  end

  ### CSS Classes ##########################

  # Max Width
  defp classes(:max_width, %{max_width: max_width}), do: "max-w-#{max_width}"

  # Variant
  defp classes(:variant, %{variant: "fixed"}), do: "fixed"
  defp classes(:variant, %{variant: "fluid"}), do: "relative"

  defp classes(_rule_group, _assigns), do: "relative"
end
