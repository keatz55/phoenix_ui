defmodule Phoenix.UI.Hooks do
  @moduledoc """
  Helper module for loading data via LiveView lifecycle events.
  """
  alias Phoenix.LiveView.Socket

  import Phoenix.LiveView, only: [attach_hook: 4]
  import Phoenix.Component, only: [assign: 3]

  @doc """
  Attaches a hook that will parse and assign a URI struct on every `handle_params` lifecycle event.
  """
  @spec on_mount(atom(), map(), map(), Socket.t()) :: {atom(), Socket.t()}
  def on_mount(:assign_uri, _params, _session, socket) do
    {:cont, attach_hook(socket, :assign_uri, :handle_params, &assign_uri/3)}
  end

  defp assign_uri(_params, uri, socket), do: {:cont, assign(socket, :uri, URI.parse(uri))}
end
