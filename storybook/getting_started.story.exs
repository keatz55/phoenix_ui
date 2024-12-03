defmodule Storybook.GettingStarted do
  use PhoenixStorybook.Story, :page

  def doc,
    do:
      "Beautifully designed components that you can copy and paste into your apps. Made with Tailwind CSS. Open source."

  def render(assigns) do
    ~H"""
    <div class="psb-getting-started-page psb-text-slate-700 dark:psb-text-slate-300">
      <p class="leading-7">
        Phoenix UI is <strong>NO LONGER</strong>
        a component library. It is now a collection of re-usable components that you can copy and paste into your apps.
      </p>

      <p class="leading-7 mt-6">
        <strong>What do you mean by not a component library?</strong>
      </p>

      <p class="leading-7 mt-6">
        I mean you no longer install it as a dependency. It is not available or distributed via hex.pm.
      </p>

      <p class="leading-7 mt-6">
        From here on out, pick the components you need. Copy and paste the code into your project and customize to your needs. The code is yours.
      </p>

      <p class="leading-7 mt-6">
        <em>Use this as a reference to build your own component libraries.</em>
      </p>
    </div>
    """
  end
end
