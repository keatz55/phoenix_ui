defmodule Storybook.Components.Breadcrumb do
  use PhoenixStorybook.Story, :component

  def function, do: &PhoenixUIWeb.Components.Breadcrumb.breadcrumb/1

  def variations do
    [
      %Variation{
        id: :basic_breadcrumbs,
        slots: [
          """
          <:item>Phoenix UI</:item>
          <:item>Core</:item>
          <:item aria-current="page">Breadcrumbs</:item>
          """
        ]
      },
      %VariationGroup{
        id: :custom_separator,
        variations:
          for icon <-
                ~w(hero-slash-mini hero-chevron-double-right-mini hero-arrow-right-mini hero-arrow-right-circle-mini)a do
            %Variation{
              attributes: %{separator_icon: to_string(icon)},
              id: icon,
              slots: [
                """
                <:item>Phoenix UI</:item>
                <:item>Core</:item>
                <:item aria-current="page">Breadcrumbs</:item>
                """
              ]
            }
          end
      }
    ]
  end
end
