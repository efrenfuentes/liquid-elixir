defmodule Liquescent.Increment do
  alias Liquescent.Tags
  alias Liquescent.Templates
  alias Liquescent.Context
  alias Liquescent.Variable
  require IEx

  def parse(%Tags{}=tag, %Templates{}=template) do
    {tag, template }
  end

  def render(output, %Tags{markup: markup}, %Context{}=context) do
    to_atom = markup |> String.to_atom
    variable = Variable.create(markup)
    { value, context } = Variable.lookup(variable, context)
    value = value || 0
    result_assign = context.assigns |> Dict.put(to_atom, value + 1)
    context = %{context | assigns: result_assign }
    { output ++ [value], context }
  end
end