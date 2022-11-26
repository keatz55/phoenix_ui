defmodule Phoenix.UI do
  @moduledoc """
  Documentation for `Phoenix.UI`.
  """

  defmacro __using__(which) when is_atom(which), do: apply(__MODULE__, which, [])

  defmacro __using__(_opts) do
    quote generated: true, location: :keep do
      alias Phoenix.UI.Components.{SelectFilter, TextFilter}

      import Phoenix.UI.Components.{
        Accordion,
        Alert,
        Avatar,
        Backdrop,
        Badge,
        Breadcrumbs,
        Button,
        Card,
        Chip,
        Collapse,
        Container,
        DescriptionList,
        Divider,
        Drawer,
        Dropdown,
        Form,
        Grid,
        Heroicon,
        Link,
        List,
        Menu,
        Modal,
        Paper,
        Table,
        Tooltip,
        Typography
      }
    end
  end

  @doc """
  Helper macro for creating a Phoenix.UI component.

  ## Examples

      use Phoenix.UI, :component

  """
  @spec component() :: Macro.t()
  def component do
    quote generated: true, location: :keep do
      alias Phoenix.LiveView.{JS, Rendered, Socket}
      alias Phoenix.UI.Theme

      import Phoenix.UI.Helpers

      use Phoenix.Component
    end
  end

  @doc """
  Helper macro for creating a Phoenix.UI live_component.

  ## Examples

      use Phoenix.UI, :live_component

  """
  @spec live_component() :: Macro.t()
  def live_component do
    quote generated: true, location: :keep do
      alias Phoenix.LiveView.{JS, Socket}

      import Phoenix.UI.Helpers

      use Phoenix.LiveComponent
    end
  end
end
