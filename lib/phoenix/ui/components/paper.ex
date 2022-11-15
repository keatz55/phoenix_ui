defmodule Phoenix.UI.Components.Paper do
  @moduledoc """
  Provides paper component.
  """
  use Phoenix.UI, :component

  attr(:blur, :boolean, default: false)
  attr(:element, :string, default: "div")
  attr(:elevation, :integer, default: 2, values: 1..5)
  attr(:extend_class, :string)
  attr(:rest, :global, include: ~w(open))
  attr(:square, :boolean, default: false)
  attr(:variant, :string, default: "elevated", values: ["elevated", "outlined"])

  slot(:inner_block, required: true)

  @doc """
  Renders paper component

  ## Examples

      ```
      <.paper>
        content
      </.paper>

  """
  @spec paper(Socket.assigns()) :: Rendered.t()
  def paper(prev_assigns) do
    assigns = assign_class(prev_assigns, ~w(
        paper transition-all ease-in-out duration-300
        #{classes(:blur, prev_assigns)}
        #{classes(:elevation, prev_assigns)}
        #{classes(:square, prev_assigns)}
        #{classes(:variant, prev_assigns)}
      ))

    ~H"""
    <.dynamic_tag class={@class} name={@element} {@rest}>
      <%= render_slot(@inner_block) %>
    </.dynamic_tag>
    """
  end

  ### CSS Classes ##########################

  # Blur
  defp classes(:blur, %{blur: false, variant: "elevated"}), do: "bg-white dark:bg-slate-800"

  defp classes(:blur, %{blur: true, variant: "elevated"}) do
    "bg-white/75 dark:bg-slate-800/75 backdrop-blur"
  end

  defp classes(:blur, %{blur: blur, variant: "elevated"}) do
    "bg-white/75 dark:bg-slate-800/75 backdrop-blur-#{blur}"
  end

  # Elevation
  defp classes(:elevation, %{variant: "outlined"}), do: nil
  defp classes(:elevation, %{elevation: 0}), do: "shadow-none"
  defp classes(:elevation, %{elevation: 1}), do: "shadow-sm"
  defp classes(:elevation, %{elevation: 2}), do: "shadow"
  defp classes(:elevation, %{elevation: 3}), do: "shadow-lg"
  defp classes(:elevation, %{elevation: 4}), do: "shadow-xl"
  defp classes(:elevation, %{elevation: 5}), do: "shadow-2xl"

  # Square
  defp classes(:square, %{square: false}), do: "rounded-lg"

  # Variant
  defp classes(:variant, %{variant: "elevated"}) do
    "border boder-slate-200 dark:border-slate-700"
  end

  defp classes(:variant, %{variant: "outlined"}), do: "border dark:border-slate-500"

  defp classes(_rule_group, _assigns), do: nil
end
