defmodule Phoenix.UI.Components.Progress do
  @moduledoc """
  Provides progress-related components.

  min-h-8
  """
  use Phoenix.UI, :component

  attr(:color, :string,
    default: "blue",
    doc: "The color of the component.",
    values: Theme.colors()
  )

  attr(:extend_class, :string,
    default: nil,
    doc: "Extend existing classes applied to the component."
  )

  attr(:rest, :global, doc: "Arbitrary HTML or phx attributes")

  attr(:size, :any, doc: "The size of the component.")

  attr(:square, :boolean, default: false, doc: "If true, rounded corners are disabled.")
  attr(:text, :string, default: nil, doc: "Draws a graphics element consisting of text")
  attr(:value, :integer, default: 30)

  attr(:variant, :string,
    default: "radial",
    doc: "The variant to use.",
    values: ["linear", "radial"]
  )

  @doc """
  A progress component displays the status of a given process.

  ## Examples

      <.progress variant="radial" />

  """
  @spec progress(Socket.assigns()) :: Rendered.t()
  def progress(%{variant: "radial"} = assigns) do
    assigns = assign_new(assigns, :size, fn -> 12 end)

    ~H"""
    <svg
      aria-hidden="true"
      class={[
        "progress block h-#{@size} w-#{@size} text-#{@color}-500",
        @extend_class
      ]}
      fill="none"
      viewBox="0 0 36 36"
      xmlns="http://www.w3.org/2000/svg"
      {@rest}
    >
      <path
        class="stroke-slate-200 dark:stroke-slate-700"
        d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831"
        fill="none"
        stroke-width="3.8"
      />
      <path
        class="stroke-current"
        d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831"
        fill="none"
        stroke-dasharray={"#{@value}, 100"}
        stroke-width="3.8"
        stroke-linecap={@square == false && "round"}
      />
      <text :if={@text} class="fill-slate-500 text-[0.5em]" text-anchor="middle" x="18" y="20.35">
        <%= @text %>
      </text>
    </svg>
    """
  end

  def progress(assigns) do
    assigns = assign_new(assigns, :size, fn -> 5 end)

    ~H"""
    <div
      class={[
        "progress w-full h-#{@size} bg-gray-200 dark:bg-gray-700",
        @square == false && "rounded-full",
        @extend_class
      ]}
      {@rest}
    >
      <div
        class={[
          "h-#{@size} bg-#{@color}-500 text-#{@color}-100 text-xs font-medium flex items-center justify-center p-0.5 leading-none",
          @square == false && "rounded-full"
        ]}
        style={"width: #{@value}%"}
      >
        <span :if={@text}><%= @text %></span>
      </div>
    </div>
    """
  end
end
