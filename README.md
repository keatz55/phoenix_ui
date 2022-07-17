# PhoenixUI

A complimentary UI library for the Phoenix Framework and Phoenix LiveView.

## Installation

Phoenix UI depends on Phoenix 1.6. Before proceeding, please ensure you have either upgraded your existing app to 1.6 or the app you have generated is using 1.6.

### 1. Install Tailwind CSS with Phoenix

Follow the [official guide](https://tailwindcss.com/docs/guides/phoenix) for setting up Tailwind CSS in a Phoenix project.

### 2. Install Phoenix UI

[Available in Hex](https://hexdocs.pm/phoenix_ui), the package can be installed by adding phoenix_ui to your list of dependencies in mix.exs:

```elixir
def deps do
  [
    {:phoenix_ui, "~> 0.1.1"},
  ]
end
```

Documentation can be found at [https://hexdocs.pm/phoenix_ui](https://hexdocs.pm/phoenix_ui).

### 3. Configure Tailwind CSS to Import Phoenix UI Classes

Add a new path pattern to `assets/tailwind.config.js` so Tailwind can import and utilize Phoenix UI css classes:

```diff
module.exports = {
  content: [
    './js/**/*.js',
    '../lib/*_web.ex',
    '../lib/*_web/**/*.*ex',

+    # Allows PhoenixUI css to be processed by JIT compiler.
+    "../deps/phoenix_ui/**/*.*ex",
  ],
  darkMode: "class",
  plugins: [],
  theme: {
    extend: {},
  },
};
```

### 4. Import Phoenix UI Components

There are multiple ways to import components. We recommend importing components in your application `{app}_web.ex` `view_helpers` function:

```elixir
  ...

  defp view_helpers do
    quote do
      ...

      # PhoenixUI macro which imports all components and JS interactions
      use PhoenixUI
      # Or import components individually
      import PhoenixUI.Components.{Button, Tooltip, ...}

      ...
    end
  end
```
