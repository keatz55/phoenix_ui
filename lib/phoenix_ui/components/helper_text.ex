defmodule PhoenixUI.Components.HelperText do
  @moduledoc """
  Provides helper text component.
  """
  use PhoenixUI, :component

  attr(:disabled, :boolean, default: false)
  attr(:element, :string, default: "div")

  @doc """
  Renders helper text component.

  ## Examples

      ```
      <.helper_text>
        We'll never share your email with anyone else.
      </.helper_text>
      ```

  """
  @spec helper_text(Socket.assigns()) :: Rendered.t()
  def helper_text(prev_assigns) do
    assigns = build_helper_text_attrs(prev_assigns)

    ~H"""
    <.dynamic_tag {@helper_text_attrs}>
      <%= render_slot(@inner_block) %>
    </.dynamic_tag>
    """
  end

  defp build_helper_text_attrs(assigns) do
    class = build_class(~w(
      mt-2 text-sm text-slate-500 dark:text-slate-400 disabled:text-slate-400 dark:disabled:text-slate-500
      #{Map.get(assigns, :extend_class)}
    ))

    attrs =
      assigns
      |> assigns_to_attributes([:extend_class, :field, :form])
      |> Keyword.put(:name, assigns[:element])
      |> Keyword.put_new(:class, class)

    assign(assigns, :helper_text_attrs, attrs)
  end
end
