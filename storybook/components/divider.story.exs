defmodule Storybook.Components.Divider do
  use PhoenixStorybook.Story, :component

  def function, do: &PhoenixUIWeb.Components.Divider.divider/1

  def variations do
    [
      %Variation{
        id: :basic
      },
      %Variation{
        attributes: %{soft: true},
        id: :soft
      }
    ]
  end
end
