defmodule PhoenixUI.Components.Backdrop do
  @moduledoc """
  Provides Backdrop component.
  """
  use PhoenixUI, :component

  attr(:element, :string, default: "div")
  attr(:invisible, :boolean, default: false)
  attr(:open, :boolean, default: true)
  attr(:transition_duration, :integer, default: 300)

  @doc """
  Renders backdrop component.

  ## Examples

      ```
      <.backdrop/>
      ```

  """
  @spec backdrop(Socket.assigns()) :: Rendered.t()
  def backdrop(prev_assigns) do
    assigns = build_backdrop_attrs(prev_assigns)

    ~H"""
    <%= if assigns[:inner_block] do %>
      <.dynamic_tag {@backdrop_attrs}>
        <%= render_slot(@inner_block) %>
      </.dynamic_tag>
    <% else %>
      <.dynamic_tag {@backdrop_attrs}></.dynamic_tag>
    <% end %>
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
    generate_all_classes(&backdrop/1,
      invisible: [true, false],
      open: [true, false],
      transition_duration: Theme.transition_durations()
    )
  end

  ### JS Interactions ##########################

  @doc """
  Hides backdrop by selector.

  ## Examples

      iex> hide_backdrop(selector)
      %JS{}

      iex> hide_backdrop(js, selector)
      %JS{}

  """
  @spec hide_backdrop(String.t()) :: struct()
  def hide_backdrop(selector), do: hide_backdrop(%JS{}, selector)

  @spec hide_backdrop(struct(), String.t()) :: struct()
  def hide_backdrop(%JS{} = js, selector) do
    JS.remove_attribute(js, "open", to: selector)
  end

  @doc """
  Shows backdrop by selector.

  ## Examples

      iex> show_backdrop(selector)
      %JS{}

      iex> show_backdrop(js, selector)
      %JS{}

  """
  @spec show_backdrop(String.t()) :: struct()
  def show_backdrop(selector), do: show_backdrop(%JS{}, selector)

  @spec show_backdrop(struct(), String.t()) :: struct()
  def show_backdrop(%JS{} = js, selector) do
    JS.set_attribute(js, {"open", "true"}, to: selector)
  end

  defp build_backdrop_attrs(assigns) do
    class = build_class(~w(
      backdrop fixed inset-0 z-50 invisible opacity-0
      open:visible open:opacity-100 transition-all ease-in-out
      #{classes(:color, assigns)}
      #{classes(:transition, assigns)}
      #{Map.get(assigns, :extend_class)}
    ))

    attrs =
      assigns
      |> assigns_to_attributes([:element, :elevation, :variant])
      |> Keyword.put_new(:class, class)
      |> Keyword.put(:name, assigns[:element])

    assign(assigns, :backdrop_attrs, attrs)
  end

  ### CSS Classes ##########################

  # Color
  defp classes(:color, %{invisible: false}), do: "bg-slate-900/70 backdrop-blur-sm"

  # Transition
  defp classes(:transition, %{transition_duration: duration}), do: "duration-#{duration}"

  defp classes(_rule_group, _assigns), do: nil
end
