defmodule Mix.Tasks.Heroicons.Generate do
  @moduledoc """
  Mix task for generating heroicon component from downloaded heroicon repo svgs.
  """
  use Mix.Task

  @impl true
  def run(_args) do
    mini_icon_markup = load_markup("20/solid")
    outline_icon_markup = load_markup("24/outline")
    solid_icon_markup = load_markup("24/solid")

    icons =
      "heroicons/optimized/**/*.svg"
      |> Path.absname(:code.priv_dir(:phoenix_ui))
      |> Path.wildcard()
      |> Enum.map(&Path.basename(&1, ".svg"))
      |> Enum.uniq()

    icon_values = Enum.map_join(icons, ", ", &"\"#{&1}\"")

    file = File.open!("lib/phoenix/ui/components/heroicon.ex", [:write])

    IO.binwrite(file, """
    defmodule Phoenix.UI.Components.Heroicon do
      @moduledoc \"\"\"
      Provides heroicon component.
      \"\"\"
      use Phoenix.UI, :component

      attr(:color, :string, default: "inherit", values: ["inherit" | Theme.colors()])
      attr(:extend_class, :string)
      attr(:name, :string, required: true, values: [#{icon_values}])
      attr(:rest, :global)
      attr(:size, :any, default: "md")
      attr(:variant, :string, default: "solid", values: ["mini", "outline", "solid"])

      @doc \"\"\"
      Renders heroicon component.

      ## Examples

          ```
          <.heroicon name="academic-cap"/>
          ```

      \"\"\"
      @spec heroicon(Socket.assigns()) :: Rendered.t()
      def heroicon(assigns) do
        assigns
        |> assign_class(~w(
          heroicon inline-block
          #\{classes(:color, assigns)\}
          #\{classes(:size, assigns)\}
        ))
        |> render_markup()
      end

      ### CSS Classes ##########################

      # Color
      defp classes(:color, %{color: "inherit"}), do: nil
      defp classes(:color, %{color: color}), do: "text-#\{color\}-500"

      # Size
      defp classes(:size, %{size: "xs"}), do: "h-4 w-4"
      defp classes(:size, %{size: "sm"}), do: "h-5 w-5"
      defp classes(:size, %{size: "md"}), do: "h-6 w-6"
      defp classes(:size, %{size: "lg"}), do: "h-8 w-8"
      defp classes(:size, %{size: "xl"}), do: "h-10 w-10"
      defp classes(:size, %{size: val}) when is_number(val), do: "w-[#\{val\}rem] h-[#\{val\}rem]"

      defp classes(_rule_group, _assigns), do: nil

      ### Markup ##########################

    """)

    Enum.each(icons, fn icon ->
      IO.binwrite(file, """
      # #{icon}
      defp render_markup(%{name: "#{icon}", variant: "mini"} = assigns) do
        ~H\"\"\"
        #{Map.get(mini_icon_markup, icon)}
        \"\"\"
      end

      defp render_markup(%{name: "#{icon}", variant: "outline"} = assigns) do
        ~H\"\"\"
        #{Map.get(outline_icon_markup, icon)}
        \"\"\"
      end

      defp render_markup(%{name: "#{icon}", variant: "solid"} = assigns) do
        ~H\"\"\"
        #{Map.get(solid_icon_markup, icon)}
        \"\"\"
      end
      """)
    end)

    IO.binwrite(file, """
    end
    """)

    File.close(file)

    Mix.Task.run("format")
  end

  defp load_markup(type) do
    "heroicons/optimized/#{type}/*.svg"
    |> Path.absname(:code.priv_dir(:phoenix_ui))
    |> Path.wildcard()
    |> Map.new(fn file ->
      {
        Path.basename(file, ".svg"),
        file
        |> File.read!()
        |> String.trim()
        |> String.replace("<svg", "<svg class={@class} {@rest}")
      }
    end)
  end
end
