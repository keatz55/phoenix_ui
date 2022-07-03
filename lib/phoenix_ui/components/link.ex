defmodule PhoenixUI.Components.Link do
  @moduledoc """
  Provides link component.
  """
  import PhoenixUI.Components.Element

  use PhoenixUI, :component

  @default_color "blue"
  @default_disabled false
  @default_variant "a"

  @doc """
  Renders link component.

  ## Examples

      ```
      <.link>
        content
      </.link>
      ```

  """
  @spec link(Socket.assigns()) :: Rendered.t()
  def link(raw) do
    assigns =
      raw
      |> assign_new(:color, fn -> @default_color end)
      |> assign_new(:disabled, fn -> @default_disabled end)
      |> assign_new(:variant, fn -> @default_variant end)
      |> build_link_attrs()

    ~H"""
    <.element {@link_attrs}>
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
    generate_all_classes(&link/1,
      color: Theme.colors(),
      disabled: [false, true],
      to: [""],
      variant: ["a", "link", "live_patch", "live_redirect"]
    )
  end

  ### Link Attrs ##########################

  defp build_link_attrs(assigns) do
    class = build_class(~w(
      link transition-all ease-in-out duration-300 cursor-pointer
      #{classes(:color, assigns)}
      #{Map.get(assigns, :extend_class)}
    ))

    attrs =
      assigns
      |> assigns_to_attributes([:color, :extend_class])
      |> Keyword.put_new(:class, class)

    assign(assigns, :link_attrs, attrs)
  end

  ### CSS Classes ##########################

  # Color
  defp classes(:color, %{color: "inherit"}), do: "text-inherit"

  defp classes(:color, %{color: "slate"}) do
    "text-slate-500 hover:text-slate-700 dark:text-slate-300 dark:hover:text-slate-100"
  end

  defp classes(:color, %{color: color}), do: "text-#{color}-500 hover:text-#{color}-700"

  defp classes(_rule_group, _assigns), do: nil
end
