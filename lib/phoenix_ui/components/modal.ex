defmodule PhoenixUI.Components.Modal do
  @moduledoc """
  Provides modal component.
  """
  import PhoenixUI.Components.{Backdrop, Paper}

  use PhoenixUI, :component

  @default_max_width :sm
  @default_open false

  @doc """
  Renders modal component.

  ## Examples

      ```
      <.modal id="basic_modal">
        <:header>
          <.typography variant="h2" margin={false}>
            Use Google's location service?
          </.typography>
        </:header>
        <:content>
          <.typography margin={false}>
            Let Google help apps determine location. This means sending anonymous location data to Google, even when no apps are running.
          </.typography>
        </:content>
        <:actions>
          <.button variant="text" color="slate" extend_class="mr-4">Disagree</.button>
          <.button variant="text">Agree</.button>
        </:actions>
      </.modal>
      ```

  """
  @spec modal(Socket.assigns()) :: Rendered.t()
  def modal(raw_assigns) do
    assigns =
      raw_assigns
      |> assign_new(:max_width, fn -> @default_max_width end)
      |> assign_new(:open, fn -> @default_open end)
      |> assign_new("phx-click-away", fn -> hide_modal("##{raw_assigns[:id]}") end)
      |> assign_new("phx-key", fn -> "escape" end)
      |> assign_new("phx-window-keydown", fn -> hide_modal("##{raw_assigns[:id]}") end)
      |> build_modal_attrs()

    ~H"""
    <.backdrop
      id={"#{@id}_modal_backdrop"}
      open={@open}
      variant="visible"
      phx-click={hide_modal("##{@id}")}
    />
    <.paper variant="elevated" {@modal_attrs}>
      <%= render_slot(@inner_block) %>
    </.paper>
    """
  end

  @doc """
  Returns all possible component classes for Tailwind CSS JIT compilation.

  ## Examples

      iex> classes()
      ["class1", "class2", ...]

  """
  @spec classes :: [String.t()]
  def classes do
    PhoenixUI.Helpers.generate_all_classes(&modal/1,
      id: ["modal"],
      max_width: [:xs, :sm, :md, :lg, :xl],
      open: [true, false]
    )
  end

  ### JS Interactions ##########################

  @spec hide_modal(String.t()) :: struct()
  def hide_modal(selector), do: hide_modal(%JS{}, selector)

  @spec hide_modal(struct(), String.t()) :: struct()
  def hide_modal(%JS{} = js, selector) do
    js
    |> JS.remove_attribute("open", to: selector)
    |> hide_backdrop("#{selector}_modal_backdrop")
  end

  @spec show_modal(String.t()) :: struct()
  def show_modal(selector), do: show_modal(%JS{}, selector)

  @spec show_modal(struct(), String.t()) :: struct()
  def show_modal(%JS{} = js, selector) do
    js
    |> JS.set_attribute({"open", "true"}, to: selector)
    |> show_backdrop("#{selector}_modal_backdrop")
  end

  ### Modal Attrs ##########################

  defp build_modal_attrs(assigns) do
    extend_class = build_class(~w(
      overflow-auto z-50 w-full max-h-[75%]
      invisible opacity-0 open:visible open:opacity-100
      fixed top-1/2 -translate-y-1/2 left-1/2 -translate-x-1/2
      transition-all ease-in-out duration-300
      #{classes(:max_width, assigns)}
      #{Map.get(assigns, :extend_class)}
    ))

    attrs =
      assigns
      |> assigns_to_attributes([:extend_class, :max_width])
      |> Keyword.put(:extend_class, extend_class)

    assign(assigns, :modal_attrs, attrs)
  end

  ### CSS Classes ##########################

  # Max Width
  defp classes(:max_width, %{max_width: size}), do: "max-w-#{size}"

  defp classes(_rule_group, _assigns), do: nil
end
