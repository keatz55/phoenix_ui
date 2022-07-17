defmodule PhoenixUI.Components.Collapse do
  @moduledoc """
  Provides collapse component.
  """
  import PhoenixUI.Components.Element

  use PhoenixUI, :component

  @default_element "div"
  @default_max_size "5000px"
  @default_open false
  @default_orientation "vertical"
  @default_transition_duration 300

  @doc """
  Renders collapse component.

  ## Examples

      ```
      <.collapse>
        content
      </.collapse>
      ```

  """
  @spec collapse(Socket.assigns()) :: Rendered.t()
  def collapse(raw_assigns) do
    assigns =
      raw_assigns
      |> assign_new(:element, fn -> @default_element end)
      |> assign_new(:max_size, fn -> @default_max_size end)
      |> assign_new(:open, fn -> @default_open end)
      |> assign_new(:orientation, fn -> @default_orientation end)
      |> assign_new(:transition_duration, fn -> @default_transition_duration end)
      |> build_collapse_attrs()

    ~H"""
    <.element {@collapse_attrs} >
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
    generate_all_classes(&collapse/1,
      max_size: Enum.map(range(100, 5000, 100), &"#{&1}px"),
      open: [true, false],
      orientation: ["horizontal", "vertical"],
      transition_duration: Theme.transition_durations()
    )
  end

  ### JS Interactions ##########################

  @doc """
  Closes collapse by selector.

  ## Examples

      iex> close_collapse(selector)
      %JS{}

      iex> close_collapse(js, selector)
      %JS{}

  """
  @spec close_collapse(String.t()) :: struct()
  def close_collapse(selector), do: close_collapse(%JS{}, selector)

  @spec close_collapse(struct(), String.t()) :: struct()
  def close_collapse(%JS{} = js, selector) do
    JS.remove_attribute(js, "open", to: selector)
  end

  @doc """
  Opens collapse by selector.

  ## Examples

      iex> open_collapse(selector)
      %JS{}

      iex> open_collapse(js, selector)
      %JS{}

  """
  @spec open_collapse(String.t()) :: struct()
  def open_collapse(selector), do: open_collapse(%JS{}, selector)

  @spec open_collapse(struct(), String.t()) :: struct()
  def open_collapse(%JS{} = js, selector) do
    JS.set_attribute(js, {"open", "true"}, to: selector)
  end

  ### Collapse Attrs ##########################

  defp build_collapse_attrs(assigns) do
    class = build_class(~w(
      collapse overflow-hidden invisible open:visible transition-all ease-in-out
      #{classes(:max_size, assigns)}
      #{classes(:open, assigns)}
      #{classes(:transition, assigns)}
      #{Map.get(assigns, :extend_class)}
    ))

    attrs =
      assigns
      |> assigns_to_attributes([:element, :max_size, :extend_class, :orientation])
      |> Keyword.put_new(:class, class)
      |> Keyword.put(:variant, assigns[:element])

    assign(assigns, :collapse_attrs, attrs)
  end

  ### CSS Classes ##########################

  # Max Size
  defp classes(:max_size, %{max_size: size, orientation: "vertical"}), do: "open:max-h-[#{size}]"

  # Open
  defp classes(:open, %{orientation: "horizontal"}), do: "max-w-0 open:max-w-full"
  defp classes(:open, %{orientation: "vertical"}), do: "max-h-0"

  # Transition
  defp classes(:transition, %{transition_duration: duration}), do: "duration-#{duration}"

  defp classes(_rule_group, _assigns), do: nil
end
