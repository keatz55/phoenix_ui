defmodule PhoenixUI.Components.Container do
  @moduledoc """
  Provides container component.
  """
  use PhoenixUI, :component

  attr(:element, :string, default: "div")
  attr(:max_width, :string, default: "screen-lg")
  attr(:variant, :string, default: "fluid")

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
  def container(prev_assigns) do
    assigns = build_container_attrs(prev_assigns)

    ~H"""
    <.dynamic_tag {@container_attrs}>
      <%= render_slot(@inner_block) %>
    </.dynamic_tag>
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
      |> Keyword.put(:name, assigns[:element])

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
