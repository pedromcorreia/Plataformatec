defmodule ToDoListWeb.UserView do
  use ToDoListWeb, :view
  alias ToDoListWeb.Coherence.ViewHelpers

  def required_label(f, name, opts \\ []), do: ViewHelpers.required_label(f, name, opts)
end
