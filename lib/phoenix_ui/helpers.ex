defmodule PhoenixUI.Helpers do
  @moduledoc """
  Provides helper functionality.
  """
  alias Phoenix.{HTML.Form, LiveView.Socket}

  import Phoenix.LiveViewTest

  use Phoenix.Component

  @doc """
  Generates a dynamically named HTML tag.

  Raises ArgumentError if the tag name is found to be unsafe HTML.

  ## Attributes

    * `:name` - The required  name of the tag, such as: "div"

  All other attributes are added to the generated tag, ensuring
  proper HTML escaping.

  ## Examples

      <.dynamic_tag name="input" type="text"/>
      => "<input type="text"/>

      <.dynamic_tag name="p">content</.dynamic_tag>
      => "<p>content</p>"
  """
  def dynamic_tag(%{name: name} = assigns) do
    rest = assigns_to_attributes(assigns)
    tag_name = to_string(name)

    tag =
      case Phoenix.HTML.html_escape(tag_name) do
        {:safe, ^tag_name} ->
          tag_name

        {:safe, _escaped} ->
          raise ArgumentError,
                "expected dynamic_tag name to be safe HTML, got: #{inspect(tag_name)}"
      end

    assigns =
      assigns
      |> assign(:tag, tag)
      |> assign(:escaped_attrs, Phoenix.HTML.attributes_escape(rest))

    if Map.has_key?(assigns, :inner_block) do
      ~H"""
      <%= {:safe, [?<, @tag]} %><%= @escaped_attrs %><%= {:safe, [?>]} %><%= render_slot(@inner_block) %><%= {:safe, [?<, ?/, @tag, ?>]} %>
      """
    else
      ~H"""
      <%= {:safe, [?<, @tag]} %><%= @escaped_attrs %><%= {:safe, [?/, ?>]} %>
      """
    end
  end

  @doc """
  Builds and normalizes list of classes.

  ## Examples

      iex> build_class([" class1", "class2 ", ...])
      "class1 class2 ..."

  """
  @spec build_class([String.t()]) :: String.t()
  def build_class(class_list), do: class_list |> Enum.join(" ") |> String.trim()

  @doc """
  Generates all possible component assigns permutations, renders ever possible
  component, scrapes, and returns a list of all possible classnames.

  ## Examples

      ["class1", "class2", ...]

  """
  @spec generate_all_classes(fun(), Keyword.t()) :: [String.t()]
  def generate_all_classes(component, attr_permutations) do
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

  @doc """
  Range function that accepts float type parameters.

  ## Examples

      iex> range(0, 2, 0.5)
      [0, 0.5, 1, 1.5, 2]

  """
  @spec range(number(), number(), number()) :: [number()]
  def range(first, last, step \\ 1), do: apply_range([truncate(first)], last, step)

  defp apply_range([current | _] = acc, last, step) when current < last do
    apply_range([truncate(current + step) | acc], last, step)
  end

  defp apply_range(acc, _last, _step), do: Enum.reverse(acc)

  defp truncate(val) do
    truncated = trunc(val)
    if val - truncated != 0, do: val, else: truncated
  end

  @doc """
  Returns true if assigns field form data has error.

  ## Examples

      iex> has_error(assigns)
      true

  """
  @spec has_error?(Socket.assigns()) :: boolean()
  def has_error?(%{field: field, form: %Form{} = f}), do: Keyword.has_key?(f.errors, field)
  def has_error?(_assigns), do: false

  @doc """
  Returns true if attr data is a slot.

  ## Examples

      iex> is_slot?(attrs)
      true

  """
  @spec is_slot?(any()) :: boolean()
  def is_slot?([%{__slot__: _} | _]), do: true
  def is_slot?(_params), do: false
end
