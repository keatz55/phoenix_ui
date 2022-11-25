defmodule Phoenix.UI.Components.SelectFilter do
  @moduledoc """
  Provides select filter component.

  The `SelectFilter` live component supports the following scenarios:
  - When passed `uri` and `param` attrs, will automatically update query param in url on select change (Default)
  - When passed `on_change` anonymous function attr, will invoke function on select change
  - When passed `on_change` event name string attr, will trigger event at parent level upon select change
  """
  alias Plug.Conn.Query

  import Phoenix.UI.Components.Select

  use Phoenix.UI, :live_component

  @default_debounce false
  @default_full_width true
  @default_handle_change "handle_change"
  @default_margin "none"
  @default_variant "simple"

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.form
        :let={f}
        for={:filter}
        id={"#{@id}_form"}
        phx-change={@handle_change}
        phx-submit={@handle_change}
        phx-target={assigns[:"phx-target"]}
      >
        <.select
          end_icon={assigns[:end_icon]}
          extend_class={assigns[:extend_class]}
          field={{f, :select}}
          full_width={@full_width}
          margin={@margin}
          options={assigns[:options]}
          phx-debounce={assigns[:"phx-debounce"]}
          prompt={assigns[:prompt]}
          start_icon={assigns[:start_icon]}
          value={assigns[:value]}
          variant={@variant}
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
      |> assign_new(:"phx-debounce", fn -> @default_debounce end)
      |> assign_new(:full_width, fn -> @default_full_width end)
      |> assign_new(:margin, fn -> @default_margin end)
      |> assign_new(:variant, fn -> @default_variant end)
      |> assign_handle_change()
    }
  end

  @impl true
  def handle_event("handle_change", %{"filter" => %{"select" => value}}, socket) do
    socket = assign(socket, :value, value)

    if is_function(socket.assigns[:on_change]) do
      {:noreply, socket.assigns.on_change.(value, socket)}
    else
      uri = socket.assigns[:uri] || URI.new("/")
      param = socket.assigns[:param] || "select_filter"

      qs =
        (uri.query || "")
        |> Query.decode()
        |> then(fn query ->
          case value do
            "" -> Map.drop(query, [param])
            value -> Map.put(query, param, value)
          end
        end)
        |> Query.encode()

      path = if qs == "", do: uri.path, else: "#{uri.path}?#{qs}"

      {:noreply, push_patch(socket, to: path, replace: true)}
    end
  end

  defp assign_handle_change(%Socket{assigns: assigns} = socket) do
    if is_bitstring(assigns[:on_change]) do
      assign(socket, :handle_change, assigns[:on_change])
    else
      assign(socket, handle_change: @default_handle_change, "phx-target": assigns.myself)
    end
  end
end
