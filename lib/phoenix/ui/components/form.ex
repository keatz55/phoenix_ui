defmodule Phoenix.UI.Components.Form do
  @moduledoc """
  Provides form components.
  """
  alias Phoenix.{HTML, HTML.Form}

  import Phoenix.UI.Components.Heroicon

  use Phoenix.UI, :component

  ### Error ##########################

  attr(:class, :string, doc: "Override the classes applied to the component.")
  attr(:element, :string, default: "p")
  attr(:extend_class, :string, doc: "Extend existing classes applied to the component.")
  attr(:rest, :global, doc: "Arbitrary HTML or phx attributes")

  slot(:inner_block, required: true)

  @doc """
  Renders error component.

  ## Examples

      <.error>
        <%= @error %>
      </.error>

  """
  @spec error(Socket.assigns()) :: Rendered.t()
  def error(assigns) do
    assigns = assign_class(assigns, ~w(
      error hidden invalid:block mt-2 text-sm text-red-500
    ))

    ~H"""
    <.dynamic_tag class={@class} name={@element} {@rest}>
      <%= render_slot(@inner_block) %>
    </.dynamic_tag>
    """
  end

  ### Form Control ##########################

  attr(:class, :string, doc: "Override the classes applied to the component.")
  attr(:element, :string, default: "div", doc: "The HTML element to use, such as `div`.")
  attr(:extend_class, :string, doc: "Extend existing classes applied to the component.")
  attr(:invalid, :boolean, default: false)

  attr(:margin, :string,
    default: "normal",
    doc: "If dense or normal, will adjust vertical spacing of this and contained components.",
    values: ["dense", "none", "normal"]
  )

  attr(:rest, :global, doc: "Arbitrary HTML or phx attributes")

  slot(:inner_block, required: true)

  @doc """
  Provides context such as filled/focused/error/required for form inputs.

  ## Examples

      <.form_control>
        <.label field={:name} form={f}>
          Name
        </.label>
        <.input
          field={:name}
          form={f}
        />
      </.form_control>

  """
  @spec form_control(Socket.assigns()) :: Rendered.t()
  def form_control(assigns) do
    assigns = assign_class(assigns, ~w(
      form-control
      #{form_control_classes(:margin, assigns)}
      #{form_control_classes(:invalid, assigns)}
    ))

    ~H"""
    <.dynamic_tag class={@class} name={@element} {@rest}>
      <%= render_slot(@inner_block) %>
    </.dynamic_tag>
    """
  end

  # Margin
  defp form_control_classes(:margin, %{margin: "normal"}), do: "mt-2 mb-4"
  defp form_control_classes(:margin, %{margin: "dense"}), do: "mt-1 mb-2"

  # Invalid
  defp form_control_classes(:invalid, %{invalid: true}), do: "invalid"

  defp form_control_classes(_rule_group, _assigns), do: nil

  ### Helper Text ##########################

  attr(:class, :string, doc: "Override the classes applied to the component.")
  attr(:element, :string, default: "div", doc: "The HTML element to use, such as `div`.")
  attr(:extend_class, :string, doc: "Extend existing classes applied to the component.")
  attr(:rest, :global, doc: "Arbitrary HTML or phx attributes")

  slot(:inner_block, required: true)

  @doc """
  Renders helper text component.

  ## Examples

      <.helper_text>
        We'll never share your email with anyone else.
      </.helper_text>

  """
  @spec helper_text(Socket.assigns()) :: Rendered.t()
  def helper_text(assigns) do
    assigns = assign_class(assigns, ~w(
      helper-text invalid:hidden mt-2 text-sm text-slate-500 dark:text-slate-400
      disabled:text-slate-400 dark:disabled:text-slate-500
    ))

    ~H"""
    <.dynamic_tag class={@class} name={@element} {@rest}>
      <%= render_slot(@inner_block) %>
    </.dynamic_tag>
    """
  end

  ### Input ##########################

  attr(:"phx-debounce", :any, default: "blur")
  attr(:"phx-feedback-for", :any)
  attr(:color, :string, default: "blue", values: Theme.colors())
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
  An input allows a user to edit data.

  ## Examples

      <.input />

  """
  @spec input(Socket.assigns()) :: Rendered.t()
  def input(assigns) do
    assigns
    |> assign_form_attrs()
    |> assign_class(~w(
        input
        #{input_classes(:default, assigns)}
        #{input_classes(:end_icon, assigns)}
        #{input_classes(:full_width, assigns)}
        #{input_classes(:start_icon, assigns)}
        #{input_classes(:variant, assigns)}
      ))
    |> input_markup()
  end

  defp input_markup(%{type: type} = assigns) when type in ["checkbox", "radio"] do
    assigns = assign_new(assigns, :checked, fn -> input_equals?(assigns.value, "true") end)

    ~H"""
    <.form_control
      margin={@margin}
      invalid={Enum.any?(@errors)}
      phx-feedback-for={assigns[:"phx-feedback-for"]}
    >
      <.label :if={@label} for={@id}>
        <input type="hidden" name={@name} value="false" />
        <input
          checked={@checked}
          class={@class}
          id={@id || @name}
          name={@name}
          type={@type}
          value="true"
          {@rest}
        />
        <%= @label %>
      </.label>
    </.form_control>
    """
  end

  defp input_markup(assigns) do
    ~H"""
    <.form_control
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
      <.error :for={error <- @errors}><%= error %></.error>
      <.helper_text :if={@helper_text}><%= @helper_text %></.helper_text>
    </.form_control>
    """
  end

  # Default
  defp input_classes(:default, %{type: type}) when type in ["checkbox", "radio"], do: "mr-4"

  defp input_classes(:default, _assigns) do
    """
    block py-2 text-slate-700 dark:text-slate-300 text-base outline-none focus:outline-none
    placeholder-slate-400 dark:placeholder-slate-400 transition-all ease-in-out duration-200
    """
  end

  # End Icon
  defp input_classes(:end_icon, %{type: "checkbox"}), do: nil
  defp input_classes(:end_icon, %{type: "radio"}), do: nil
  defp input_classes(:end_icon, %{end_icon: nil}), do: "pr-3"
  defp input_classes(:end_icon, _assigns), do: "pr-12"

  # Start Icon
  defp input_classes(:start_icon, %{type: "checkbox"}), do: nil
  defp input_classes(:start_icon, %{type: "radio"}), do: nil
  defp input_classes(:start_icon, %{start_icon: nil}), do: "pl-3"
  defp input_classes(:start_icon, _assigns), do: "pl-12"

  # Variant - Simple
  defp input_classes(:variant, %{type: "checkbox"}), do: ""
  defp input_classes(:variant, %{type: "radio"}), do: ""

  defp input_classes(:variant, %{color: color, variant: "simple"}) do
    """
    bg-white dark:bg-slate-900 rounded-md border-slate-300 shadow-sm
    focus:border-#{color}-300 focus:ring-1 focus:ring-#{color}-500 focus:ring-opacity-50
    invalid:border-red-500 invalid:focus:border-red-300 invalid:focus:ring-red-300
    """
  end

  # Variant - Solid
  defp input_classes(:variant, %{color: color, variant: "solid"}) do
    """
    rounded-md bg-slate-100 shadow-sm border border-transparent dark:bg-slate-800
    focus:bg-transparent dark:focus:bg-transparent focus:border-#{color}-500
    invalid:border-red-500 invalid:focus:border-red-300 invalid:focus:ring-red-300
    """
  end

  # Variant - Underline
  defp input_classes(:variant, %{color: color, variant: "underline"}) do
    """
    bg-transparent border-0 border-b-2 border-slate-400
    hover:border-slate-600
    focus:ring-0 focus:border-#{color}-700
    invalid:border-red-400 invalid:focus:border-red-700
    """
  end

  # Variant - Unstyled
  defp input_classes(:variant, %{variant: "unstyled"}) do
    """
    bg-white dark:bg-slate-900
    invalid:border-red-500 invalid:focus:ring-red-500 invalid:focus:border-red-500
    """
  end

  # Width
  defp input_classes(:full_width, %{type: "checkbox"}), do: nil
  defp input_classes(:full_width, %{type: "radio"}), do: nil
  defp input_classes(:full_width, %{full_width: true}), do: "w-full"

  defp input_classes(_rule_group, _assigns), do: nil

  ### Label ##########################

  attr(:for, :string, default: nil)
  attr(:rest, :global, doc: "Arbitrary HTML or phx attributes")

  slot(:inner_block, required: true)

  @doc """
  Renders label component.

  ## Examples

      <.label for={@id}>
        Name
      </.label>

  """
  @spec label(Socket.assigns()) :: Rendered.t()
  def label(assigns) do
    assigns = assign_class(assigns, ~w(
      label flex items-center mb-2 text-slate-600 dark:text-slate-300
      disabled:text-slate-500 dark:disabled:text-slate-400 invalid:text-red-500
    ))

    ~H"""
    <label class={@class} for={@for} {@rest}>
      <%= render_slot(@inner_block) %>
    </label>
    """
  end

  ### Select ##########################

  attr(:"phx-debounce", :any, default: "blur")
  attr(:"phx-feedback-for", :string)
  attr(:errors, :list)
  attr(:extend_class, :string, doc: "Extend existing classes applied to the component.")
  attr(:field, :any, doc: "a %Phoenix.HTML.Form{}/field name tuple, for example: {f, :email}")
  attr(:full_width, :boolean, default: false)
  attr(:helper_text, :string, default: nil)
  attr(:id, :any)
  attr(:label, :string, default: nil)
  attr(:margin, :string, default: "normal", values: ["dense", "none", "normal"])
  attr(:multiple, :boolean, default: false, doc: "the multiple flag for selects")
  attr(:name, :any)
  attr(:options, :list, doc: "the options to pass to Phoenix.HTML.Form.options_for_select/2")
  attr(:prompt, :string, default: nil, doc: "the prompt for selects")

  attr(:rest, :global,
    include:
      ~w(autocomplete disabled form max maxlength min minlength pattern placeholder readonly required size step)
  )

  attr(:start_icon, :map, default: nil, doc: "Heroicon-specific attrs to use, such as `name`.")
  attr(:type, :string, default: "text")
  attr(:value, :any)
  attr(:variant, :string, default: "simple", values: ["simple", "solid", "underline", "unstyled"])

  @doc """
  Select allows users to make a single selection or multiple selections from a list of options.

  ## Examples

      <.select options={@options} />

  """
  @spec select(Socket.assigns()) :: Rendered.t()
  def select(assigns) do
    assigns =
      assigns
      |> assign_form_attrs()
      |> assign_class(~w(
        select
        #{input_classes(:default, assigns)}
        #{input_classes(:end_icon, assigns)}
        #{input_classes(:full_width, assigns)}
        #{input_classes(:start_icon, assigns)}
        #{input_classes(:variant, assigns)}
      ))

    ~H"""
    <.form_control
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
        <select
          class={@class}
          id={@id}
          multiple={@multiple}
          name={@name}
          phx-debounce={assigns[:"phx-debounce"]}
          {@rest}
        >
          <option :if={@prompt} value><%= @prompt %></option>
          <%= Form.options_for_select(@options, @value) %>
        </select>
      </div>
      <.error :for={error <- @errors}><%= error %></.error>
      <.helper_text :if={@helper_text}><%= @helper_text %></.helper_text>
    </.form_control>
    """
  end

  ### Textarea ##########################

  attr(:"phx-debounce", :any, default: "blur")
  attr(:"phx-feedback-for", :any)
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
      ~w(autocomplete disabled form max maxlength min minlength pattern placeholder readonly rows required size step)
  )

  attr(:start_icon, :map, default: nil, doc: "Heroicon-specific attrs to use, such as `name`.")
  attr(:type, :string, default: "text")
  attr(:value, :any)
  attr(:variant, :string, default: "simple", values: ["simple", "solid", "underline", "unstyled"])

  @doc """
  A text area lets users enter long form text which spans over multiple lines.

  ## Examples

      ```
      <.textarea />
      ```

  """
  @spec textarea(Socket.assigns()) :: Rendered.t()
  def textarea(assigns) do
    assigns =
      assigns
      |> assign_form_attrs()
      |> assign_class(~w(
        textarea
        #{input_classes(:default, assigns)}
        #{input_classes(:end_icon, assigns)}
        #{input_classes(:start_icon, assigns)}
        #{input_classes(:variant, assigns)}
        #{input_classes(:full_width, assigns)}
      ))

    ~H"""
    <.form_control
      margin={@margin}
      invalid={Enum.any?(@errors)}
      phx-feedback-for={assigns[:"phx-feedback-for"]}
    >
      <.label :if={@label} for={@id}><%= @label %></.label>
      <div class={["relative inline-flex", if(@full_width, do: "w-full")]}>
        <div :if={@start_icon} class="start-icon pl-3 absolute left-0 top-2 text-slate-500">
          <.heroicon {@start_icon} />
        </div>
        <textarea
          class={@class}
          id={@id || @name}
          name={@name}
          phx-debounce={assigns[:"phx-debounce"]}
          {@rest}
        ><%= @value %></textarea>
        <div :if={@end_icon} class="end-icon px-3 absolute right-0 top-2 text-slate-500">
          <.heroicon {@end_icon} />
        </div>
      </div>
      <.error :for={error <- @errors}><%= error %></.error>
      <.helper_text :if={@helper_text}><%= @helper_text %></.helper_text>
    </.form_control>
    """
  end

  defp assign_form_attrs(%{field: {f, field}} = assigns) do
    assigns
    |> assign(field: nil)
    |> assign_new(:"phx-feedback-for", fn -> Form.input_name(f, field) end)
    |> assign_new(:errors, fn -> translate_errors(f.errors || [], field) end)
    |> assign_new(:id, fn -> Form.input_id(f, field) end)
    |> assign_new(:name, fn -> Form.input_name(f, field) end)
    |> assign_new(:value, fn -> Form.input_value(f, field) end)
  end

  defp input_equals?(val1, val2), do: HTML.html_escape(val1) == HTML.html_escape(val2)
end
