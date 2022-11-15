defmodule Phoenix.UI.Components.Drawer do
  @moduledoc """
  Provides drawer component.
  """
  import Phoenix.UI.Components.{Backdrop, Paper}

  use Phoenix.UI, :component

  attr(:anchor, :string, default: "left", values: ["bottom", "left", "right", "top"])
  attr(:extend_class, :string)
  attr(:id, :string, required: true)
  attr(:open, :boolean, default: false)
  attr(:rest, :global)
  attr(:square, :boolean, default: true)
  attr(:variant, :string, default: "temporary", values: ["temporary"])

  @doc """
  Renders drawer component.

  ## Examples

      ```
      <.drawer id="basic_drawer">
        content
      </.drawer>
      ```

  """
  @spec drawer(Socket.assigns()) :: Rendered.t()
  def drawer(prev_assigns) do
    extend_class = build_class(~w(
      fixed overflow-hidden z-50 invisible open:visible
      transition-all ease-in-out duration-300
      #{classes(:anchor, prev_assigns)}
      #{classes(:open, prev_assigns)}
      #{Map.get(prev_assigns, :extend_class)}
    ))

    assigns = assign(prev_assigns, :extend_class, extend_class)

    ~H"""
    <.backdrop id={"#{@id}_drawer_backdrop"} open={@open} phx-click={hide_drawer("##{@id}")}>
    </.backdrop>
    <.paper
      extend_class={@extend_class}
      id={@id}
      open={@open}
      phx-click-away={hide_drawer("##{@id}")}
      phx-key="escape"
      phx-window-keydown={hide_drawer("##{@id}")}
      square={@square}
      variant="elevated"
      {@rest}
    >
      <%= render_slot(@inner_block) %>
    </.paper>
    """
  end

  ### JS Interactions ##########################

  @doc """
  Hides drawer matching selector.

  ## Examples

      iex> hide_drawer(selector)
      %JS{}

      iex> hide_drawer(js, selector)
      %JS{}

  """
  @spec hide_drawer(String.t()) :: struct()
  def hide_drawer(selector), do: hide_drawer(%JS{}, selector)

  @spec hide_drawer(struct(), String.t()) :: struct()
  def hide_drawer(%JS{} = js, selector) do
    js
    |> JS.remove_attribute("open", to: selector)
    |> hide_backdrop("#{selector}_drawer_backdrop")
  end

  @doc """
  Shows drawer matching selector.

  ## Examples

      iex> show_drawer(selector)
      %JS{}

      iex> show_drawer(js, selector)
      %JS{}

  """
  @spec show_drawer(String.t()) :: struct()
  def show_drawer(selector), do: show_drawer(%JS{}, selector)

  @spec show_drawer(struct(), String.t()) :: struct()
  def show_drawer(%JS{} = js, selector) do
    js
    |> JS.set_attribute({"open", "true"}, to: selector)
    |> show_backdrop("#{selector}_drawer_backdrop")
  end

  ### CSS Classes ##########################

  # Anchor
  defp classes(:anchor, %{anchor: "bottom"}), do: "bottom-0 left-0 right-0"
  defp classes(:anchor, %{anchor: "left"}), do: "bottom-0 left-0 top-0"
  defp classes(:anchor, %{anchor: "right"}), do: "bottom-0 right-0 top-0"
  defp classes(:anchor, %{anchor: "top"}), do: "left-0 right-0 top-0"

  # Open
  defp classes(:open, %{anchor: "bottom"}), do: "max-h-0 open:max-h-full"
  defp classes(:open, %{anchor: "left"}), do: "max-w-0 open:max-w-full"
  defp classes(:open, %{anchor: "right"}), do: "max-w-0 open:max-w-full"
  defp classes(:open, %{anchor: "top"}), do: "max-h-0 open:max-h-full"

  defp classes(_rule_group, _assigns), do: nil
end
