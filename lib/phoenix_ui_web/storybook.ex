defmodule PhoenixUIWeb.Storybook do
  @moduledoc false
  use PhoenixStorybook,
    color_mode: true,
    color_mode_icons: [
      dark: {:local, "hero-moon", nil, "psb-h-5 psb-w-5"},
      light: {:local, "hero-sun", nil, "psb-h-5 psb-w-5"},
      system: {:local, "hero-computer-desktop", nil, "psb-h-5 psb-w-5"}
    ],
    content_path: Path.expand("../../storybook", __DIR__),
    css_path: "/assets/storybook.css",
    js_path: "/assets/storybook.js",
    otp_app: :phoenix_ui_web,
    sandbox_class: "phoenix-ui-web",
    title: "Phoenix UI"
end
