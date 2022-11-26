defmodule Mix.Tasks.Tailwind.GenerateClasses do
  @moduledoc """
  Mix task for generating, parsing, and referencing all Phoenix UI classes.
  """
  alias Phoenix.{HTML.FormData.Atom, HTML.Form, UI.Theme}

  import Phoenix.{Component, LiveViewTest}

  use Mix.Task
  use Phoenix.UI

  @impl true
  def run(_args) do
    Application.put_env(:phoenix, :json_library, Jason)
    File.mkdir_p!("lib/phoenix_ui/tailwind")
    file = File.open!("lib/phoenix/ui/tailwind/generated_classes.ex", [:write])

    IO.binwrite(file, """
    defmodule Phoenix.UI.Tailwind.GeneratedClasses do
      @moduledoc \"\"\"
      Referential Phoenix.UI classes for JIT compilation:
      \"\"\"
      # credo:disable-for-next-line Credo.Check.Readability.MaxLineLength
    """)

    IO.binwrite(file, "#")

    [
      # Accordion
      {
        &accordion/1,
        [
          header: [[%{inner_block: fn _, _ -> "header" end}]],
          id: ["accordion"],
          open: [true, false],
          panel: [[%{inner_block: fn _, _ -> "panel" end}]]
        ]
      },
      # Alert
      {
        &alert/1,
        [
          action: [["phx-click": "lv:clear-flash"]],
          severity: ["error", "info", "success", "warning"],
          variant: ["filled", "outlined", "standard"]
        ]
      },
      # AvatarGroup
      {
        &avatar_group/1,
        [
          avatar: [[%{inner_block: nil}]],
          color: Theme.colors(),
          inner_block: [nil, []],
          size: ["xs", "sm", "md", "lg", "xl"],
          spacing: ["xs", "sm", "md", "lg", "xl"],
          variant: ["circular", "rounded", "square"]
        ]
      },
      # Avatar
      {
        &avatar/1,
        [
          inner_block: [[]],
          color: Theme.colors(),
          border: [true, false],
          size: ["xs", "sm", "md", "lg", "xl"] ++ range(0.25, 20, 0.25),
          variant: ["circular", "rounded", "square"]
        ]
      },
      # Backdrop
      {
        &backdrop/1,
        [
          invisible: [true, false],
          open: [true, false],
          transition_duration: Theme.transition_durations()
        ]
      },
      # Badge
      {
        &badge/1,
        [
          color: Theme.colors(),
          content: [""],
          position: [
            "bottom_end",
            "bottom_start",
            "bottom",
            "left_end",
            "left_start",
            "left",
            "right_end",
            "right_start",
            "right",
            "top_end",
            "top_start",
            "top"
          ],
          variant: ["dot", "standard"]
        ]
      },
      # Breadcrumb
      {
        &breadcrumbs/1,
        [
          a: [
            [
              %{inner_block: fn _, _ -> "Phoenix UI" end},
              %{inner_block: fn _, _ -> "Components" end}
            ]
          ]
        ]
      },
      # Button
      {
        &button/1,
        [
          color: Theme.colors(),
          disabled: [true, false],
          size: ["xs", "sm", "md", "lg", "xl"],
          square: [true, false],
          variant: ["contained", "icon", "outlined", "text"]
        ]
      },
      # Card
      {
        &card/1,
        [
          elevation: [0, 1, 2, 3, 4, 5],
          square: [true, false],
          variant: ["elevated", "outlined"]
        ]
      },
      # Card Header
      {&card_header/1, []},
      # Card Media
      {&card_media/1, [src: [""]]},
      # Card Content
      {&card_content/1, []},
      # Card Actions
      {&card_action/1, []},
      # Chip
      {
        &chip/1,
        [
          color: Theme.colors(),
          label: ["label"],
          on_click: ["handle_click"],
          on_delete: ["handle_delete"],
          variant: ["filled", "outlined"]
        ]
      },
      # Collapse
      {
        &collapse/1,
        [
          max_size: Enum.map(range(100, 5000, 100), &"#{&1}px"),
          open: [true, false],
          orientation: ["horizontal", "vertical"],
          transition_duration: Theme.transition_durations()
        ]
      },
      # Container
      {
        &container/1,
        [
          max_width: Theme.max_widths(),
          variant: ["fixed", "fluid"]
        ]
      },
      # Divider
      {
        &divider/1,
        [
          color: Theme.colors(),
          variant: ["full_width", "inset", "middle"]
        ]
      },
      # Drawer
      {
        &drawer/1,
        [
          id: ["drawer"],
          open: [true, false],
          variant: [:temporary]
        ]
      },
      # Grid
      {
        &grid/1,
        [
          column_spacing: 1..12,
          columns: 1..12,
          row_spacing: 1..12,
          spacing: 1..12
        ]
      },
      # Heroicon
      {
        &heroicon/1,
        [
          color: Theme.colors(),
          name: ["academic-cap"],
          size: ["xs", "sm", "md", "lg", "xl"] ++ range(0.25, 20, 0.25),
          variant: ["outline", "solid"]
        ]
      },
      # Input
      {
        &input/1,
        [
          color: Theme.colors(),
          field: [
            {%Form{
               source: :filter,
               impl: Atom,
               id: "form",
               name: "input",
               data: %{},
               params: %{},
               options: []
             }, :text}
          ],
          type: ["text", "checkbox"],
          variant: ["simple", "solid", "underline", "unstyled"]
        ]
      },
      # Link
      {
        &link/1,
        [
          color: Theme.colors(),
          disabled: [false, true]
        ]
      },
      # List
      {&list/1, []},
      # List Item
      {&list_item/1, []},
      # Modal
      {
        &modal/1,
        [
          id: ["modal"],
          max_width: [:xs, :sm, :md, :lg, :xl],
          open: [true, false]
        ]
      },
      # Paper
      {
        &paper/1,
        [
          blur: [true, false, "none", "sm", "md", "lg", "xl", "2xl", "3xl"],
          elevation: [0, 1, 2, 3, 4, 5],
          square: [true, false],
          variant: ["elevated", "outlined"]
        ]
      },
      # Tooltip
      {
        &tooltip/1,
        [
          color: Theme.colors(),
          content: [""],
          position: [
            "bottom_end",
            "bottom_start",
            "bottom",
            "left_end",
            "left_start",
            "left",
            "right_end",
            "right_start",
            "right",
            "top_end",
            "top_start",
            "top"
          ],
          variant: ["arrow", "simple"]
        ]
      },
      # Typography
      {
        &typography/1,
        [
          align: ["center", "justify", "left", "right"],
          color: Theme.colors(),
          variant: ["h1", "h2", "h3", "h4", "p"]
        ]
      }
    ]
    |> Enum.map(fn {fun, args} -> generate_component_classes(fun, args) end)
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.sort()
    |> Enum.each(fn class ->
      IO.binwrite(file, " #{class}")
    end)

    IO.binwrite(file, """

    end
    """)

    File.close(file)

    Mix.Task.run("format")
  end

  defp generate_component_classes(component, attr_permutations) do
    attr_permutations
    |> Keyword.put_new(:inner_block, [[]])
    |> Enum.map(fn {prop, opts} ->
      Enum.map(opts, fn opt -> Map.put(%{}, prop, opt) end)
    end)
    |> Enum.reduce(nil, &permutation/2)
    |> Enum.map(&extract_classes(&1, component))
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.sort()
  end

  defp permutation(set1, nil), do: set1

  defp permutation(set1, set2) do
    Enum.reduce(set1, [], fn item1, acc ->
      Enum.reduce(set2, acc, fn item2, acc ->
        [Map.merge(item1, item2) | acc]
      end)
    end)
  end

  defp extract_classes(assigns, component) do
    html = render_component(component, assigns)

    ~r/(?<=class=\").*?(?=\")/
    |> Regex.scan(html)
    |> List.flatten()
    |> Enum.map(&String.split/1)
  end

  defp range(first, last, step), do: apply_range([truncate(first)], last, step)

  defp apply_range([current | _] = acc, last, step) when current < last do
    apply_range([truncate(current + step) | acc], last, step)
  end

  defp apply_range(acc, _last, _step), do: Enum.reverse(acc)

  defp truncate(val) do
    truncated = trunc(val)
    if val - truncated != 0, do: val, else: truncated
  end
end
