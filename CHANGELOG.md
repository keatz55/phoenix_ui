# Changelog

## 0.1.8 (2023-03-06)

### Enhancements

- Fixes Phoenix LiveView v0.18.16 form warnings

## 0.1.7 (2022-11-30)

### Enhancements

- Adds `progress` component w/ `radial` and `linear` variants
- Improves `heroicon` sizing

## 0.1.6 (2022-11-28)

### Enhancements

- Adds `SelectFilter` and updates existing `TextFilter` live component will now support the following scenarios:
  - When passed `uri` and `param` attrs, will automatically update query param in url on text change (Default)
  - When passed `on_change` anonymous function attr, will invoke function on text change
  - When passed `on_change` event name string attr, will trigger event at parent level upon text change
- Adds `Phoenix.UI.Hooks` `:assign_uri` helper for making URI available for every `:handle_params` lifecycle event
- Adds `Textarea` component

## 0.1.5 (2022-11-20)

### Enhancements

- Improves and adds error styles for select component.
- Improves TextFilter live component
- Button component compilation warning fixes
- Increased testing for the following
  - button
  - select
  - text_field
  - text_filter

## 0.1.4 (2022-11-17)

### Enhancements

- Improves and adds error styles for text_field component.
- Improves TextFilter live component
- text_field related components
  - form_group
  - label
  - error_tag
  - helper_text
- misc docs cleanup

## 0.1.3 (2022-11-15)

### Enhancements

- Adds attr color, name, variant, etc. compile-time warnings for the following components:
  - avatar
  - avatar_group
  - backdrop
  - button
  - button_group
  - card
  - chip
  - collapse
  - container
  - drawer
  - heroicon
  - paper
  - typography
- Updates typography component to support bold and size attributes
