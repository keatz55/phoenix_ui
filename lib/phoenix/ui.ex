defmodule Phoenix.UI do
  @moduledoc """
  Documentation for `Phoenix.UI`.
  """

  defmacro __using__(which) when is_atom(which), do: apply(__MODULE__, which, [])

  defmacro __using__(_opts) do
    quote generated: true, location: :keep do
      alias Phoenix.UI.Components.{Autocomplete, Dropdown, SelectFilter, TextFilter}

      import Phoenix.UI.Components.{
        Accordion,
        Alert,
        Avatar,
        AvatarGroup,
        Backdrop,
        Badge,
        Breadcrumbs,
        Button,
        ButtonGroup,
        Card,
        Chip,
        Collapse,
        Container,
        DescriptionList,
        Divider,
        Drawer,
        Dropdown,
        ErrorTag,
        FormGroup,
        Grid,
        HelperText,
        Heroicon,
        Label,
        Link,
        List,
        Menu,
        Modal,
        Paper,
        Progress,
        Select,
        Table,
        Textarea,
        TextField,
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
