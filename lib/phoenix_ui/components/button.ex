defmodule Phoenix.UI.Components.Button do
  @moduledoc """
  Provides button component.
  """
  use Phoenix.UI, :component

  attr(:color, :string, default: "blue")
  attr(:disabled, :boolean, default: false)
  attr(:element, :string, default: "button")
  attr(:size, :string, default: "md")
  attr(:square, :boolean, default: false)
  attr(:type, :string, default: "button")
  attr(:variant, :string, default: "contained")

  @doc """
  Renders button component.

  ## Examples

      ```
      <.button>
        Click me
      </.button>
      ```

  """
  @spec button(Socket.assigns()) :: Rendered.t()
  def button(prev_assigns) do
    assigns = build_btn_attrs(prev_assigns)

    ~H"""
    <.dynamic_tag {@btn_attrs}>
      <%= render_slot(@inner_block) %>
    </.dynamic_tag>
    """
  end

  ### Btn Attrs ##########################

  defp build_btn_attrs(assigns) do
    class = build_class(~w(
      button tracking-wider uppercase outline-none focus:outline-none text-center transition
      duration-200 ease-in-out disabled:opacity-50 disabled:cursor-not-allowed
      #{classes(:color, assigns)}
      #{classes(:size, assigns)}
      #{classes(:square, assigns)}
      #{classes(:variant, assigns)}
      #{Map.get(assigns, :extend_class)}
    ))

    attrs =
      assigns
      |> assigns_to_attributes([:color, :element, :extend_class, :size, :square, :variant])
      |> Keyword.put_new(:class, class)
      |> Keyword.put_new(:name, assigns[:element])

    assign(assigns, :btn_attrs, attrs)
  end

  ### CSS Classes ##########################

  # Color
  defp classes(:color, %{color: color, variant: "contained"}) do
    "bg-#{color}-500 hover:bg-#{color}-700 disabled:hover:bg-#{color}-500"
  end

  defp classes(:color, %{color: color, variant: "icon"}) do
    "text-#{color}-500 hover:text-#{color}-700 dark:hover:text-#{color}-300 hover:bg-#{color}-500/20 disabled:bg-transparent disabled:text-#{color}-500"
  end

  defp classes(:color, %{color: color, variant: "outlined"}) do
    "text-#{color}-500 border-#{color}-500 hover:text-#{color}-700 hover:border-#{color}-700 hover:bg-#{color}-700/20 disabled:bg-transparent disabled:border-#{color}-500 disabled:text-#{color}-500"
  end

  defp classes(:color, %{color: color, variant: "text"}) do
    "text-#{color}-500 dark:text-#{color}-400 hover:text-#{color}-700 hover:bg-#{color}-500/20 disabled:bg-transparent disabled:text-#{color}-500"
  end

  # Size
  defp classes(:size, %{size: "xs", variant: "icon"}), do: "p-1 text-xs"
  defp classes(:size, %{size: "sm", variant: "icon"}), do: "p-2 text-xs"
  defp classes(:size, %{variant: "icon"}), do: "p-3 text-xs"
  defp classes(:size, %{size: "sm"}), do: "py-2 px-3 text-xs"
  defp classes(:size, %{size: "md"}), do: "py-2 px-4 text-base font-semibold"
  defp classes(:size, %{size: "lg"}), do: "py-3 px-5 text-xl font-bold"

  # Square
  defp classes(:square, %{variant: "icon"}), do: "rounded-full"
  defp classes(:square, %{square: false}), do: "rounded"

  # Variant
  defp classes(:variant, %{variant: "contained"}), do: "text-white shadow"
  defp classes(:variant, %{variant: "outlined"}), do: "bg-transparent border border-solid"
  defp classes(:variant, %{variant: "text"}), do: "bg-transparent"

  defp classes(_rule_group, _assigns), do: nil
end
