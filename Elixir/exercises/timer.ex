defmodule Timer do
  def remind(remind, time) do
    spawn(fn ->
      :timer.sleep(seconds * 1000)
      IO.puts reminder
    end)
  end
end
