defmodule PhoenixUI.Components.TextFilter do
  @moduledoc """
  Provides text filter component.
  """
  import PhoenixUI.Components.{Heroicon, TextInput}

  use PhoenixUI, :live_component

  @default_debounce 300
  @default_end_icon "x"
  @default_label false
  @default_start_icon "search"

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.form
        for={:filter}
        id={"#{@id}_form"}
        let={f}
      >
        <.text_input
          field="text"
          form={f}
          {@text_input_attrs}
        />
      </.form>
    </div>
    """
  end

  @impl true
  def update(assigns, socket) do
    {
      :ok,
      socket
      |> assign(assigns)
      |> assign_new(:on_change, fn -> fn _val, comp_socket -> comp_socket end end)
      |> assign_new(:"phx-change", fn -> phx_change(assigns) end)
      |> assign_new(:"phx-debounce", fn -> @default_debounce end)
      |> assign_new(:"phx-target", fn -> socket.assigns.myself end)
      |> assign_new(:clear_icon, fn -> @default_end_icon end)
      |> assign_new(:label, fn -> @default_label end)
      |> assign_new(:start_icon, fn -> [name: @default_start_icon] end)
      |> assign_new(:value, fn -> assigns[:default_value] end)
      |> build_text_input_attrs()
    }
  end

  @impl true
  def handle_event("handle_clear", _params, socket) do
    socket
    |> assign(:value, nil)
    |> socket.assigns.on_clear.()
  end

  def handle_event("handle_change", %{"filter" => %{"text" => value}}, socket) do
    socket.assigns.on_change.(value, assign(socket, :value, value))
  end

  ### Text Input Attrs ##########################

  defp build_text_input_attrs(%Socket{assigns: assigns} = socket) do
    attrs =
      assigns
      |> assigns_to_attributes([:end_icon, :id, :on_clear, :on_change, :text_input_attrs])
      |> apply_end_icon(assigns)

    assign(socket, text_input_attrs: attrs)
  end

  defp apply_end_icon(attrs, %{value: val} = assigns) when val not in [nil, ""] do
    icon = [
      "phx-click": phx_click(assigns),
      "phx-target": assigns[:"phx-target"],
      extend_class: "cursor-pointer",
      name: "x"
    ]

    Keyword.put(attrs, :end_icon, icon)
  end

  defp apply_end_icon(attrs, _assigns), do: attrs

  defp phx_change(%{on_change: str}) when is_bitstring(str), do: str
  defp phx_change(assigns), do: "handle_change"

  defp phx_click(%{on_clear: str}) when is_bitstring(str), do: str
  defp phx_click(assigns), do: "handle_clear"
end
