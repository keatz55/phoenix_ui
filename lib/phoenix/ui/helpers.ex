defmodule Phoenix.UI.Helpers do
  @moduledoc """
  Provides helper functionality.
  """
  alias Phoenix.{HTML.Form, LiveView.Socket}

  import Phoenix.Component

  @doc """
  Builds and normalizes list of classes.

  ## Examples

      iex> assign_class(assigns, [" class1", "class2 ", ...])
      %{class: "class1 class2 ...", ..}

  """
  @spec assign_class(Socket.assigns(), [String.t()]) :: Socket.assigns()
  def assign_class(assigns, []), do: assigns

  def assign_class(assigns, class_list) do
    assign_new(assigns, :class, fn ->
      if extend_class = Map.get(assigns, :extend_class) do
        [extend_class | Enum.reverse(class_list)]
        |> Enum.reverse()
        |> Enum.join(" ")
        |> String.trim()
      else
        class_list |> Enum.join(" ") |> String.trim()
      end
    end)
  end

  @doc """
  Builds and normalizes list of classes.

  ## Examples

      iex> assign_extend_class(assigns, [" class1", "class2 ", ...])
      %{class: "class1 class2 ...", ..}

  """
  @spec assign_extend_class(Socket.assigns(), [String.t()]) :: Socket.assigns()
  def assign_extend_class(assigns, []), do: assigns

  def assign_extend_class(assigns, extend_class_list) do
    extend_class =
      if extend_class = Map.get(assigns, :extend_class) do
        [extend_class | extend_class_list] |> Enum.reverse() |> Enum.join(" ") |> String.trim()
      else
        extend_class_list |> Enum.join(" ") |> String.trim()
      end

    assign(assigns, :extend_class, extend_class)
  end

  @doc """
  Builds and normalizes list of classes.

  ## Examples

      iex> assign_rest(assigns, exclude)
      %{...}

  """
  @spec assign_rest(Socket.assigns()) :: Socket.assigns()
  @spec assign_rest(Socket.assigns(), [atom()]) :: Socket.assigns()
  def assign_rest(assigns, exclude \\ []) do
    assign(assigns, :rest, assigns_to_attributes(assigns, exclude))
  end

  @doc """
  Builds and normalizes list of classes.

  ## Examples

      iex> build_class([" class1", "class2 ", ...])
      "class1 class2 ..."

  """
  @spec build_class([String.t()]) :: String.t()
  def build_class(class_list), do: class_list |> Enum.join(" ") |> String.trim()

  @doc """
  Returns true if assigns field form data has error.

  ## Examples

      iex> has_error(assigns)
      true

  """
  @spec has_error?(Socket.assigns()) :: boolean()
  def has_error?(%{field: field, form: %Form{} = f}), do: Keyword.has_key?(f.errors, field)
  def has_error?(_assigns), do: false

  @doc """
  Returns true if attr data is a slot.

  ## Examples

      iex> is_slot?(attrs)
      true

  """
  @spec is_slot?(any()) :: boolean()
  def is_slot?([%{__slot__: _} | _]), do: true
  def is_slot?(_params), do: false

  @error_message """
    Missing translate_error_module config. Add the following to your config/config.exe
    config :phoenix_ui, translate_error_module: YourAppWeb.ErrorHelpers
  """

  @doc """
  Translates an error message using gettext.
  """
  def translate_error(error) do
    if module = Application.get_env(:phoenix_ui, :translate_error_module) do
      module.translate_error(error)
    else
      raise ArgumentError, message: @error_message
    end
  end

  @doc """
  Translates the errors for a field from a keyword list of errors.
  """
  def translate_errors(errors, field) when is_list(errors) do
    for {^field, {msg, opts}} <- errors, do: translate_error({msg, opts})
  end
end
