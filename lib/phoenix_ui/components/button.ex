defmodule PhoenixUI.Components.Button do
  @moduledoc """
  Provides button component.
  """
  import PhoenixUI.Components.Element

  use PhoenixUI, :component

  @default_color "blue"
  @default_disabled false
  @default_element "button"
  @default_size "md"
  @default_square false
  @default_type "button"
  @default_variant "contained"

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
  def button(raw) do
    assigns =
      raw
      |> assign_new(:color, fn -> @default_color end)
      |> assign_new(:disabled, fn -> @default_disabled end)
      |> assign_new(:element, fn -> @default_element end)
      |> assign_new(:size, fn -> @default_size end)
      |> assign_new(:square, fn -> @default_square end)
      |> assign_new(:type, fn -> @default_type end)
      |> assign_new(:variant, fn -> @default_variant end)
      |> build_btn_attrs()

    ~H"""
    <.element {@btn_attrs}>
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
    generate_all_classes(&button/1,
      color: Theme.colors(),
      disabled: [true, false],
      size: ["xs", "sm", "md", "lg", "xl"],
      square: [true, false],
      variant: ["contained", "icon", "outlined", "text"]
    )
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
      |> Keyword.put_new(:variant, assigns[:element])

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
