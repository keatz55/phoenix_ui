defmodule Storybook.Components do
  use PhoenixStorybook.Index

  def folder_icon, do: {:fa, "toolbox", :thin}
  def folder_open?, do: true

  def entry("badge"), do: [icon: {:fa, "badge-check", :thin}]
end
