defmodule Phoenix.UI.Components.TextField do
  @moduledoc """
  Provides text input component.
  """
  alias Phoenix.HTML.Form

  import Phoenix.UI.Components.{ErrorTag, FormGroup, HelperText, Heroicon, Label}

  use Phoenix.UI, :component

  attr(:"phx-debounce", :any, default: "blur")
  attr(:"phx-feedback-for", :string)
  attr(:end_icon, :map, default: nil, doc: "Heroicon-specific attrs to use, such as `name`.")
  attr(:errors, :list)
  attr(:extend_class, :string, doc: "Extend existing classes applied to the component.")
  attr(:field, :any, doc: "a %Phoenix.HTML.Form{}/field name tuple, for example: {f, :email}")
  attr(:full_width, :boolean, default: false)
  attr(:helper_text, :string, default: nil)
  attr(:id, :any)
  attr(:label, :string, default: nil)
  attr(:margin, :string, default: "normal", values: ["dense", "none", "normal"])
  attr(:name, :any)

  attr(:rest, :global,
    include:
      ~w(autocomplete disabled form max maxlength min minlength pattern placeholder readonly required size step)
  )

  attr(:start_icon, :map, default: nil, doc: "Heroicon-specific attrs to use, such as `name`.")
  attr(:type, :string, default: "text")
  attr(:value, :any)
  attr(:variant, :string, default: "simple", values: ["simple", "solid", "underline", "unstyled"])

  @doc """
  Renders text input field component.

  ## Examples

      ```
      <.text_field />
      ```

  """
  @spec text_field(Socket.assigns()) :: Rendered.t()
  def text_field(%{field: {f, field}} = assigns) do
    assigns =
      assigns
      |> assign(field: nil)
      |> assign_class(~w(
        input block py-2 px-3 text-slate-700 dark:text-slate-300 text-base outline-none focus:outline-none
        placeholder-slate-400 dark:placeholder-slate-400 transition-all ease-in-out duration-200
        #{classes(:background, assigns)}
        #{classes(:end_icon, assigns)}
        #{classes(:rounded, assigns)}
        #{classes(:start_icon, assigns)}
        #{classes(:variant, assigns)}
        #{classes(:width, assigns)}
      ))
      |> assign_new(:"phx-feedback-for", fn -> Form.input_name(f, field) end)
      |> assign_new(:errors, fn -> translate_errors(f.errors || [], field) end)
      |> assign_new(:id, fn -> Form.input_id(f, field) end)
      |> assign_new(:name, fn -> Form.input_name(f, field) end)
      |> assign_new(:value, fn -> Form.input_value(f, field) end)

    ~H"""
    <.form_group
      margin={@margin}
      invalid={Enum.any?(@errors)}
      phx-feedback-for={assigns[:"phx-feedback-for"]}
    >
      <.label :if={@label} for={@id}><%= @label %></.label>
      <div class={["relative inline-flex", if(@full_width, do: "w-full")]}>
        <div
          :if={@start_icon}
          class="start-icon pl-3 absolute left-0 top-1/2 -translate-y-1/2 text-slate-500"
        >
          <.heroicon {@start_icon} />
        </div>
        <input
          class={@class}
          id={@id || @name}
          name={@name}
          phx-debounce={assigns[:"phx-debounce"]}
          type={@type}
          value={@value}
          {@rest}
        />
        <div
          :if={@end_icon}
          class="end-icon px-3 absolute right-0 top-1/2 -translate-y-1/2 text-slate-500"
        >
          <.heroicon {@end_icon} />
        </div>
      </div>
      <.error_tag :for={error <- @errors}><%= error %></.error_tag>
      <.helper_text :if={@helper_text}><%= @helper_text %></.helper_text>
    </.form_group>
    """
  end

  ### CSS Classes ##########################

  # Background
  defp classes(:background, %{variant: "solid"}) do
    "bg-slate-100 dark:bg-slate-800 focus:bg-transparent dark:focus:bg-transparent"
  end

  defp classes(:background, %{variant: "underline"}), do: "bg-transparent"
  defp classes(:background, _assigns), do: "bg-white dark:bg-slate-900"

  # End Icon
  defp classes(:end_icon, %{end_icon: nil}), do: "pr-3"
  defp classes(:end_icon, _assigns), do: "pr-12"

  # Rounded
  defp classes(:rounded, %{variant: "underline"}), do: nil
  defp classes(:rounded, %{variant: "unstyled"}), do: nil
  defp classes(:rounded, _assigns), do: "rounded-md"

  # Start Icon
  defp classes(:start_icon, %{start_icon: nil}), do: "pl-3"
  defp classes(:start_icon, _assigns), do: "pl-12"

  # Variant - Simple
  defp classes(:variant, %{variant: "simple"}) do
    """
    border border-slate-300 shadow-sm focus:border-blue-300 focus:ring focus:ring-opacity-50 focus:ring-blue-200
    invalid:border-red-500 invalid:focus:border-red-300 invalid:focus:ring-red-300
    """
  end

  # Variant - Solid
  defp classes(:variant, %{variant: "solid"}) do
    "shadow-sm border border-transparent focus:border-slate-500 invalid:border-red-500"
  end

  # Variant - Underline
  defp classes(:variant, %{variant: "underline"}) do
    "border-b-2 border-slate-300 shadow-sm focus:border-slate-600 invalid:border-red-300 invalid:focus:border-red-600"
  end

  # Variant - Unstyled
  defp classes(:variant, %{variant: "unstyled"}) do
    """
    border border-slate-300 shadow-sm ring-0 focus:ring-1 focus:ring-blue-500 focus:border-blue-500
    invalid:border-red-300 invalid:focus:ring-red-500 invalid:focus:border-red-500
    """
  end

  # Width
  defp classes(:width, %{full_width: true}), do: "w-full"

  defp classes(_rule_group, _assigns), do: nil
end
