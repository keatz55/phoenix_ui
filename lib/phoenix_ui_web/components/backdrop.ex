defmodule PhoenixUIWeb.Components.Backdrop do
  @moduledoc """
  Provides backdrop-related components and helper functions.
  """
  use Phoenix.Component

  alias Phoenix.LiveView.JS
  alias Phoenix.LiveView.Rendered
  alias Phoenix.LiveView.Socket

  @doc """
  The Backdrop component narrows the user's focus to a particular element on the screen.

  ## Examples

  ```heex
  <.backdrop/>
  ```
  """

  attr :class, :any, doc: "Extend existing component styles"
  attr :default_open, :boolean, default: false
  attr :element, :string, default: "div"
  attr :id, :string, required: true
  attr :invisible, :boolean, default: false
  attr :rest, :global

  slot :inner_block

  @spec backdrop(Socket.assigns()) :: Rendered.t()
  def backdrop(assigns) do
    ~H"""
    <.dynamic_tag
      class={[
        "backdrop fixed inset-0 z-20 invisible opacity-0 data-[open]:visible data-[open]:opacity-100 transition-all duration-200 ease-in-out",
        styles(:color, assigns),
        assigns[:class]
      ]}
      data-open={@default_open}
      id={assigns[:id]}
      tag_name={@element}
      {@rest}
    >
      {render_slot(@inner_block)}
    </.dynamic_tag>
    """
  end

  ### Styles ##########################

  # Color
  defp styles(:color, %{invisible: false}), do: "bg-zinc-900/25 backdrop-blur-sm"

  defp styles(_, _), do: nil

  ### JS Interactions ##########################

  @doc """
  Hides backdrop by id.

  ## Examples

      iex> hide_backdrop(id)
      %JS{}

      iex> hide_backdrop(js, id)
      %JS{}

  """
  @spec hide_backdrop(JS.t(), String.t()) :: JS.t()
  def hide_backdrop(js \\ %JS{}, id) do
    JS.remove_attribute(js, "data-open", to: "##{id}")
  end

  @doc """
  Shows backdrop by id.

  ## Examples

      iex> show_backdrop(id)
      %JS{}

      iex> show_backdrop(js, id)
      %JS{}

  """
  @spec show_backdrop(JS.t(), String.t()) :: JS.t()
  def show_backdrop(js \\ %JS{}, id) do
    JS.set_attribute(js, {"data-open", ""}, to: "##{id}")
  end
end
