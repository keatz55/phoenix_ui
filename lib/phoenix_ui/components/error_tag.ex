defmodule PhoenixUI.Components.ErrorTag do
  @moduledoc """
  Provides error tag component.
  """
  import Phoenix.HTML.Form
  import PhoenixUI.Components.Element

  use PhoenixUI, :component

  @default_color "red"
  @default_variant "p"

  @doc """
  Renders error tag component.

  ## Examples

      ```
      <.error_tag form={f} field={:field} />
      ```

  """
  @spec error_tag(Socket.assigns()) :: Rendered.t()
  def error_tag(raw_assigns) do
    assigns =
      raw_assigns
      |> assign_new(:color, fn -> @default_color end)
      |> assign_new(:variant, fn -> @default_variant end)
      |> build_error_attrs()
      |> translate_errors()

    ~H"""
    <%= for error <- @errors do %>
      <.element {@error_attrs}>
        <%= error %>
      </.element>
    <% end %>
    """
  end

  ### Error Attrs ##########################

  defp build_error_attrs(%{field: field, form: form} = assigns) do
    extend_class = build_class(~w(
      invalid-feedback mt-2 text-sm text-red-500
      #{Map.get(assigns, :extend_class)}
    ))

    attrs =
      assigns
      |> assigns_to_attributes([:field, :form, :extend_class])
      |> Keyword.put(:phx_feedback_for, input_name(form, field))
      |> Keyword.put(:extend_class, extend_class)

    assign(assigns, :error_attrs, attrs)
  end

  ### Translate Errors ##########################

  defp translate_errors(%{field: field, form: form} = assigns) do
    errors = form.errors |> Keyword.get_values(field) |> Enum.map(&translate_error/1)
    assign(assigns, :errors, errors)
  end

  @error_message """
    Missing translate_error_module config. Add the following to your config/config.exe
    config :phoenix_ui, translate_error_module: YourAppWeb.ErrorHelpers
  """

  defp translate_error(error) do
    if module = Application.get_env(:phoenix_ui, :translate_error_module) do
      module.translate_error(error)
    else
      raise ArgumentError, message: @error_message
    end
  end
end
