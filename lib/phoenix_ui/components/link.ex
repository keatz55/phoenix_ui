defmodule Phoenix.UI.Components.Link do
  @moduledoc """
  Provides a component.
  """
  use Phoenix.UI, :component

  @default_color "blue"
  @default_disabled false

  @doc """
  Renders a component.

  ## Examples

      ```
      <.a>
        content
      </.a>
      ```

  """
  @spec a(Socket.assigns()) :: Rendered.t()
  def a(raw) do
    assigns =
      raw
      |> assign_new(:color, fn -> @default_color end)
      |> assign_new(:disabled, fn -> @default_disabled end)
      |> build_link_attrs()

    ~H"""
    <.link {@link_attrs}>
      <%= render_slot(@inner_block) %>
    </.link>
    """
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
