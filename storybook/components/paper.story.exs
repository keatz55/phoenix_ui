defmodule Storybook.Components.Paper do
  use PhoenixStorybook.Story, :component

  def function, do: &PhoenixUIWeb.Components.Paper.paper/1

  def template do
    """
    <div class="grid grid-cols-2 gap-4 text-zinc-700 dark:text-zinc-300 text-center" psb-code-hidden>
      <.psb-variation-group/>
    </div>
    """
  end

  def variations do
    [
      %VariationGroup{
        id: :corners,
        variations: [
          %Variation{
            attributes: %{class: "p-4"},
            id: :default,
            slots: ["rounded corners"]
          },
          %Variation{
            attributes: %{class: "p-4", square: true},
            id: :square,
            slots: ["square corners"]
          }
        ]
      },
      %VariationGroup{
        id: :elevation,
        variations:
          for elevation <- 0..5 do
            %Variation{
              id: :"elevation_#{elevation}",
              attributes: %{
                class: "p-4",
                elevation: elevation
              },
              slots: ["elevation=#{elevation}"]
            }
          end
      }
    ]
  end
end
