defmodule PhoenixUIWeb.Components.Popover do
  @moduledoc """
  Provides popover-related components and helper functions.
  """
  use Phoenix.Component

  import PhoenixUIWeb.Components.Backdrop, only: [backdrop: 1]
  import PhoenixUIWeb.Components.Paper, only: [paper: 1]

  alias Phoenix.LiveView.JS
  alias Phoenix.LiveView.Rendered
  alias Phoenix.LiveView.Socket

  @doc """
  A Popover can be used to display some content on top of another.

  ## Examples

  ```heex
  <.popover id="basic_popover">
    content
  </.popover>
  ```
  """
  attr :class, :any, doc: "Extend existing component styles"
  attr :default_open, :boolean, default: false, doc: "The default expanded state"
  attr :element, :string, default: "div", doc: "The HTML element to use, such as `div`"
  attr :id, :string, doc: "the id of the popover", required: true
  attr :position, :string, default: "bottom"
  attr :rest, :global, doc: "the arbitrary HTML attributes to add to the flash container"

  slot :inner_block, required: true

  @spec popover(Socket.assigns()) :: Rendered.t()
  def popover(assigns) do
    ~H"""
    <.backdrop
      class="popover-backdrop"
      default_open={@default_open}
      id={"#{@id}-backdrop"}
      invisible
      phx-click={hide_popover(@id)}
    />
    <.paper
      class={[
        "popover absolute z-20",
        "hidden data-[open]:block opacity-0 data-[open]:opacity-100",
        styles(:margin, assigns),
        styles(:position, assigns),
        assigns[:class]
      ]}
      data-open={@default_open}
      element={assigns[:element]}
      id={@id}
      {@rest}
    >
      {render_slot(@inner_block)}
    </.paper>
    """
  end

  defp styles(:margin, %{position: "bottom" <> _}), do: "mt-2"
  defp styles(:margin, %{position: "top" <> _}), do: "mb-2"

  defp styles(:position, %{position: "bottom_end"}), do: "top-full right-0"
  defp styles(:position, %{position: "bottom_start"}), do: "top-full left-0"
  defp styles(:position, %{position: "bottom"}), do: "top-full left-1/2 -translate-x-1/2"
  defp styles(:position, %{position: "left_end"}), do: "right-full bottom-0"
  defp styles(:position, %{position: "left_start"}), do: "right-full top-0"
  defp styles(:position, %{position: "left"}), do: "right-full top-1/2 -translate-y-1/2"
  defp styles(:position, %{position: "right_end"}), do: "left-full bottom-0"
  defp styles(:position, %{position: "right_start"}), do: "left-full top-0"
  defp styles(:position, %{position: "right"}), do: "left-full top-1/2 -translate-y-1/2"
  defp styles(:position, %{position: "top_end"}), do: "bottom-full right-0"
  defp styles(:position, %{position: "top_start"}), do: "bottom-full left-0"
  defp styles(:position, %{position: "top"}), do: "bottom-full left-1/2 -translate-x-1/2"

  defp styles(_, _), do: nil

  @doc """
  Hides popover matching id.

  ## Examples

      iex> hide_popover(id)
      %JS{}

      iex> hide_popover(js, id)
      %JS{}

  """
  @spec hide_popover(JS.t(), String.t()) :: JS.t()
  def hide_popover(js \\ %JS{}, id) do
    js
    |> JS.remove_attribute("data-open", to: "##{id}")
    |> JS.remove_attribute("data-open", to: "##{id}-backdrop")
  end

  @doc """
  Shows popover matching id.

  ## Examples

      iex> show_popover(id)
      %JS{}

      iex> show_popover(js, id)
      %JS{}

  """
  @spec show_popover(JS.t(), String.t()) :: JS.t()
  def show_popover(js \\ %JS{}, id) do
    js
    |> JS.set_attribute({"data-open", ""}, to: "##{id}")
    |> JS.set_attribute({"data-open", ""}, to: "##{id}-backdrop")
  end

  @doc """
  Toggles popover matching id.

  ## Examples

      iex> toggle_popover(id)
      %JS{}

      iex> toggle_popover(js, id)
      %JS{}

  """
  @spec toggle_popover(JS.t(), String.t()) :: JS.t()
  def toggle_popover(js \\ %JS{}, id) do
    js
    |> JS.toggle_attribute({"data-open", ""}, to: "##{id}")
    |> JS.toggle_attribute({"data-open", ""}, to: "##{id}-backdrop")
  end
end
