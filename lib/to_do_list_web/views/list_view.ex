defmodule ToDoListWeb.ListView do
  use ToDoListWeb, :view

  def show_list(list), do: "lists/" <> to_string(Map.get(list, :id))

  def status_goal(goal), do: if (Map.get(goal, :status) == "done"), do: "-done"

  def difference_date(list) do
    difference_time = Timex.diff(Timex.now, list.inserted_at, :seconds)

    cond do
      difference_time < 60 ->
        "#{difference_time} second#{diffence_plural(difference_time, 0)} ago"

      difference_time >= 60 and difference_time < 3600 ->
        minutes = Kernel.trunc(difference_time / 60)
        "#{minutes} minute#{diffence_plural(minutes, 1)} ago"

      difference_time >= 3600 and difference_time < 86400 ->
        hours = Kernel.trunc(difference_time / 3600)
        "#{hours} hour#{diffence_plural(hours, 1)} ago"

      difference_time >= 86400 and difference_time < 604800->
        days = Kernel.trunc(difference_time / 86400)
        "#{days} day#{diffence_plural(days, 1)} ago"

      difference_time >= 604800 ->
        weeks = Kernel.trunc(difference_time / 604800)
        "#{weeks} week#{diffence_plural(weeks, 1)} ago"
    end
  end
  defp diffence_plural(difference_time, minimum), do: if difference_time != minimum, do: "s"
end
