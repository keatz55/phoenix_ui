defmodule PhoenixUI do
  @moduledoc """
  Documentation for `PhoenixUI`.
  """

  defmacro __using__(which) when is_atom(which), do: apply(__MODULE__, which, [])

  defmacro __using__(_opts) do
    quote generated: true, location: :keep do
      alias PhoenixUI.Components.{Autocomplete, Dropdown, SelectFilter, TextFilter}

      import PhoenixUI.Components.Divider, only: [divider: 1]

      import PhoenixUI.Components.{
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
        Checkbox,
        Chip,
        Collapse,
        Container,
        DescriptionList,
        Drawer,
        Dropdown,
        ErrorTag,
        FormGroup,
        Grid,
        HelperText,
        Heroicon,
        HiddenInput,
        Label,
        A,
        List,
        Menu,
        Modal,
        Paper,
        Select,
        Table,
        Textarea,
        TextInput,
        Tooltip,
        Typography
      }
    end
  end

  @doc """
  Helper macro for creating a PhoenixUI component.

  ## Examples

      use PhoenixUI, :component

  """
  @spec component() :: Macro.t()
  def component do
    quote generated: true, location: :keep do
      alias Phoenix.LiveView.{JS, Rendered, Socket}
      alias PhoenixUI.Theme

      import PhoenixUI.Helpers

      use Phoenix.Component
    end
  end

  @doc """
  Helper macro for creating a PhoenixUI live_component.

  ## Examples

      use PhoenixUI, :live_component

  """
  @spec live_component() :: Macro.t()
  def live_component do
    quote generated: true, location: :keep do
      alias Phoenix.LiveView.Socket

      import PhoenixUI.Helpers

      use Phoenix.LiveComponent
    end
  end
end
