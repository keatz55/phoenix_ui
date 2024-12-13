defmodule PhoenixUIWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, components, channels, and so on.

  This can be used in your application as:

      use PhoenixUIWeb, :controller
      use PhoenixUIWeb, :html

  The definitions below will be executed for every controller,
  component, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define additional modules and import
  those modules here.
  """

  @doc """
  references static paths found in priv
  """
  def static_paths, do: ~w(assets fonts images favicon.ico robots.txt)

  @doc """
  import router functionality
  """
  def router do
    quote do
      use Phoenix.Router, helpers: false

      # Import common connection and controller functions to use in pipelines
      import Plug.Conn
      import Phoenix.Controller
      import Phoenix.LiveView.Router
    end
  end

  @doc """
  import channel functionality
  """
  def channel do
    quote do
      use Phoenix.Channel
    end
  end

  @doc """
  import component functionality
  """
  def component(_opts \\ []) do
    quote do
      use Phoenix.Component

      alias Phoenix.LiveView.JS
      alias Phoenix.LiveView.Rendered
      alias Phoenix.LiveView.Socket
    end
  end

  @doc """
  import controller functionality
  """
  def controller do
    quote do
      use Phoenix.Controller,
        formats: [:html, :json],
        layouts: [html: PhoenixUIWeb.Layouts]

      import Plug.Conn
      import PhoenixUIWeb.Gettext

      unquote(verified_routes())
    end
  end

  @doc """
  import liveview functionality
  """
  def live_view do
    quote do
      use Phoenix.LiveView,
        layout: {PhoenixUIWeb.Layouts, :app}

      unquote(html_helpers())
    end
  end

  @doc """
  import live component functionality
  """
  def live_component do
    quote do
      use Phoenix.LiveComponent

      unquote(html_helpers())
    end
  end

  @doc """
  import html functionality
  """

  def html do
    quote do
      use Phoenix.Component

      # Import convenience functions from controllers
      import Phoenix.Controller,
        only: [get_csrf_token: 0, view_module: 1, view_template: 1]

      # Include general helpers for rendering HTML
      unquote(html_helpers())
    end
  end

  defp html_helpers do
    quote do
      # HTML escaping functionality
      import Phoenix.HTML
      # Core UI components and translation
      import PhoenixUIWeb.CoreComponents
      import PhoenixUIWeb.Gettext

      # Shortcut for generating JS commands
      alias Phoenix.LiveView.JS

      # Routes generation with the ~p sigil
      unquote(verified_routes())
    end
  end

  def verified_routes do
    quote do
      use Phoenix.VerifiedRoutes,
        endpoint: PhoenixUIWeb.Endpoint,
        router: PhoenixUIWeb.Router,
        statics: PhoenixUIWeb.static_paths()
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/live_view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
