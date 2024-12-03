defmodule Storybook.Components.Popover do
  use PhoenixStorybook.Story, :component

  def function, do: &PhoenixUIWeb.Components.Popover.popover/1

  def imports do
    [
      {PhoenixUIWeb.Components.Button, [button: 1]},
      {PhoenixUIWeb.Components.Popover, [toggle_popover: 1]},
      {PhoenixUIWeb.CoreComponents, [icon: 1]}
    ]
  end

  def template do
    """
    <div class="relative mb-2 last:mb-0 text-zinc-700 dark:text-zinc-300" psb-code-hidden>
      <.button phx-click={toggle_popover(":variation_id")}>
        <span>Open popover</span>
        <.icon class="icon" name="hero-chevron-down-micro" />
      </.button>
      <.psb-variation/>
    </div>
    """
  end

  def variations do
    [
      %Variation{
        attributes: %{class: "p-4"},
        id: :basic,
        slots: ["Content"]
      },
      %VariationGroup{
        id: :position,
        variations:
          for position <- ~w(top left right bottom)a do
            %Variation{
              attributes: %{class: "p-4", position: to_string(position)},
              id: position,
              slots: [position |> to_string() |> String.capitalize()]
            }
          end
      }
    ]
  end
end
