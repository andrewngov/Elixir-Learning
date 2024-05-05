defmodule Recurse do
  def loopy([head | tail]) do
    IO.puts "Head: #{head} Tail: #{inspect(tail)}"
    loopy(tail)
  end

  def loopy([]), do: IO.puts "Done!"

  def sum([head | tail], acc \\ 0) do
    sum(tail, head + acc)
  end

  def sum([], acc), do: acc

  def triple([head | tail], acc \\ []) do
    triple(tail, [head * 3 | acc])
  end

  def triple([], acc), do: acc |> Enum.reverse()

  def my_map([head | tail], func) do
    [func.(head) | my_map(tail, func)]
  end

  def my_map([], _), do: []
end

Recurse.loopy([1, 2, 3, 4, 5])
