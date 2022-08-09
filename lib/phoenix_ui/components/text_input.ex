defmodule PhoenixUI.Components.TextInput do
  @moduledoc """
  Provides text input component.
  """
  import Phoenix.HTML.Form, only: [text_input: 3]
  import PhoenixUI.Components.{ErrorTag, FormGroup, HelperText, Heroicon, Label}

  use PhoenixUI, :component

  @default_full_width false
  @default_icon_color "inherit"
  @default_phx_debounce "blur"
  @default_type "text"
  @default_variant "simple"

  @doc """
  Renders text input component.

  ## Examples

      ```
      <.text_input />
      ```

  """
  @spec text_input(Socket.assigns()) :: Rendered.t()
  def text_input(raw) do
    assigns =
      raw
      |> assign_new(:"phx-debounce", fn -> @default_phx_debounce end)
      |> assign_new(:full_width, fn -> @default_full_width end)
      |> assign_new(:type, fn -> @default_type end)
      |> assign_new(:variant, fn -> @default_variant end)
      |> assign(:invalid?, has_error?(raw))
      |> build_text_input_attrs()
      |> build_start_icon_attrs()
      |> build_end_icon_attrs()

    ~H"""
    <.form_group extend_class={assigns[:extend_class]}>
      <%= if assigns[:form] && assigns[:label] == nil do %>
        <.label
          field={@field}
          form={@form}
          phx_feedback_for={Phoenix.HTML.Form.input_name(@form, @field)}
          invalid?={assigns[:invalid?]}
        />
      <% end %>
      <%= if assigns[:form] && assigns[:label] do %>
        <.label
          field={@field}
          form={@form}
          phx_feedback_for={Phoenix.HTML.Form.input_name(@form, @field)}
          invalid?={assigns[:invalid?]}
        >
          <%= @label %>
        </.label>
      <% end %>
      <div class="relative">
        <%= if assigns[:start_icon] do %>
          <div class="pl-3 absolute left-0 top-1/2 -translate-y-1/2 text-slate-500">
            <.heroicon {@start_icon_attrs} />
          </div>
        <% end %>
        <%= if assigns[:form] do %>
          <%= text_input @form, @field, @text_input_attrs %>
        <% else %>
          <input {@input_attrs}/>
        <% end %>
        <%= if assigns[:end_icon] do %>
          <div class="px-3 absolute right-0 top-1/2 -translate-y-1/2 text-slate-500">
            <.heroicon {@end_icon_attrs} />
          </div>
        <% end %>
      </div>
      <%= if assigns[:invalid?] do %>
        <.error_tag field={@field} form={@form} />
      <% end %>
      <%= if assigns[:helper_text] && !assigns[:invalid?] do %>
        <.helper_text>
          <%= @helper_text %>
        </.helper_text>
      <% end %>
    </.form_group>
    """
  end

  ### Text Input Attrs ##########################

  defp build_text_input_attrs(assigns) do
    class = build_class(~w(
      block py-2 px-3 text-slate-700 dark:text-slate-300 text-base outline-none focus:outline-none
      placeholder-slate-400 dark:placeholder-slate-400 transition-all ease-in-out duration-200
      #{classes(:background, assigns)}
      #{classes(:end_icon, assigns)}
      #{classes(:invalid, assigns)}
      #{classes(:rounded, assigns)}
      #{classes(:start_icon, assigns)}
      #{classes(:variant, assigns)}
      #{classes(:width, assigns)}
      #{Map.get(assigns, :extend_class)}
    ))

    attrs =
      assigns
      |> assigns_to_attributes([
        :end_icon,
        :extend_class,
        :field,
        :form,
        :invalid?,
        :start_icon,
        :variant
      ])
      |> Keyword.put_new(:class, class)

    assign(assigns, :text_input_attrs, attrs)
  end

  ### Start Icon Attrs ##########################

  defp build_start_icon_attrs(%{start_icon: icon} = assigns) do
    attrs =
      icon
      |> assigns_to_attributes()
      |> Keyword.put_new(:color, @default_icon_color)

    assign(assigns, :start_icon_attrs, attrs)
  end

  defp build_start_icon_attrs(assigns), do: assigns

  ### End Icon Attrs ##########################

  defp build_end_icon_attrs(%{end_icon: icon} = assigns) do
    attrs =
      icon
      |> assigns_to_attributes()
      |> Keyword.put_new(:color, @default_icon_color)

    assign(assigns, :end_icon_attrs, attrs)
  end

  defp build_end_icon_attrs(assigns), do: assigns

  ### CSS Classes ##########################

  # Background
  defp classes(:background, %{variant: "solid"}) do
    "bg-slate-100 dark:bg-slate-800 focus:bg-transparent dark:focus:bg-transparent"
  end

  defp classes(:background, %{variant: "underline"}), do: "bg-transparent"
  defp classes(:background, _assigns), do: "bg-white dark:bg-slate-900"

  # End Icon
  defp classes(:end_icon, %{end_icon: _}), do: "pr-12"
  defp classes(:end_icon, _assigns), do: "pr-3"

  # Invalid
  defp classes(:invalid, %{invalid?: true}), do: "invalid"

  # Rounded
  defp classes(:rounded, %{variant: "underline"}), do: nil
  defp classes(:rounded, %{variant: "unstyled"}), do: nil
  defp classes(:rounded, _assigns), do: "rounded-md"

  # Start Icon
  defp classes(:start_icon, %{start_icon: _}), do: "pl-12"
  defp classes(:start_icon, _assigns), do: "pl-3"

  # Variant - Simple
  defp classes(:variant, %{variant: "simple"}) do
    """
    border border-slate-300 shadow-sm focus:border-blue-300 focus:ring focus:ring-opacity-50 focus:ring-blue-200
    invalid:border-red-500 invalid:focus:border-red-300 invalid:focus:ring-red-200
    """
  end

  # Variant - Solid
  defp classes(:variant, %{variant: "solid"}) do
    "shadow-sm border border-transparent focus:border-slate-500"
  end

  # Variant - Underline
  defp classes(:variant, %{variant: "underline"}) do
    "border-b-2 border-slate-300 shadow-sm focus:border-slate-600"
  end

  # Variant - Unstyled
  defp classes(:variant, %{variant: "unstyled"}) do
    "border border-slate-300 shadow-sm ring-0 focus:ring-1 focus:ring-blue-500 focus:border-blue-500"
  end

  # Width
  defp classes(:width, %{full_width: true}), do: "w-full"

  defp classes(_rule_group, _assigns), do: nil
end
