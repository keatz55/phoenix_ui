defmodule Storybook.Components.Accordion do
  use PhoenixStorybook.Story, :component

  @default_class "bg-white dark:bg-zinc-800 rounded-lg border border-zinc-200 dark:border-zinc-700"
  @default_panel_class "p-4"
  @default_trigger_class "p-4 pr-10 text-lg"

  def function, do: &PhoenixUIWeb.Components.Accordion.accordion/1

  def template do
    """
    <div class="text-zinc-700 dark:text-zinc-200 [&_button]:text-left" psb-code-hidden>
      <.psb-variation-group/>
    </div>
    """
  end

  def variations do
    [
      %Variation{
        attributes: %{class: @default_class},
        id: :basic,
        slots:
          for idx <- 1..3 do
            """
            <:trigger class="#{@default_trigger_class}">
              Accordion #{idx}
            </:trigger>
            <:panel class="#{@default_panel_class}">
              Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse malesuada lacus ex, sit amet blandit leo lobortis eget.
            </:panel>
            """
          end
      },
      %Variation{
        attributes: %{class: @default_class, controlled: true},
        id: :controlled_accordion,
        slots:
          for idx <- 1..2 do
            """
            <:trigger class="#{@default_trigger_class}">
              Accordion #{idx}
            </:trigger>
            <:panel class="#{@default_panel_class}">
              Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse malesuada lacus ex, sit amet blandit leo lobortis eget.
            </:panel>
            """
          end
      },
      %Variation{
        attributes: %{class: @default_class},
        id: :expand_icon,
        slots:
          for {icon, idx} <- Enum.with_index(~w(hero-arrow-down hero-arrow-down-circle)) do
            """
            <:trigger class="#{@default_trigger_class}" icon_name="#{icon}">
              Accordion #{idx + 1}
            </:trigger>
            <:panel class="#{@default_panel_class}">
              Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse malesuada lacus ex, sit amet blandit leo lobortis eget.
            </:panel>
            """
          end
      },
      %Variation{
        attributes: %{class: @default_class},
        description: "Expanded by default",
        id: :default_expanded,
        slots: [
          """
          <:trigger class="#{@default_trigger_class}">
            Accordion
          </:trigger>
          <:panel class="#{@default_panel_class}" default_expanded>
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse malesuada lacus ex, sit amet blandit leo lobortis eget.
          </:panel>
          """
        ]
      },
      %Variation{
        attributes: %{class: @default_class},
        description: "Max height panel override",
        id: :max_height_class,
        slots: [
          """
          <:trigger class="#{@default_trigger_class}">
            Accordion
          </:trigger>
          <:panel class="#{@default_panel_class} max-h-40 overflow-y-auto">
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse malesuada lacus ex, sit amet blandit leo lobortis eget.
            <br />
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse malesuada lacus ex, sit amet blandit leo lobortis eget.
          </:panel>
          """
        ]
      }
    ]
  end
end
