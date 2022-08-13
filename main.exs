defmodule Game do
  def main(input_arr) do
    # chunk stuff first
    neighbor_count_arr =
      input_arr
      |> Enum.map(fn row -> setup_arr(row, 0) |> Enum.map(&neighbor_summer/1) end)
      |> setup_arr(List.duplicate({0, 0}, length(List.first(input_arr))))
      |> Enum.map(&vertical_summer/1)

    overlay(input_arr, neighbor_count_arr)
    |> Enum.map(fn row -> Enum.map(row, &cell_logic/1) end)
  end

  def overlay(two_d_arr1, two_d_arr2) do
    List.zip([two_d_arr1, two_d_arr2])
    |> Enum.map(fn {first, second} -> Enum.zip(first, second) end)
  end

  def setup_arr(arr, filler) do
    # chunk_every needs MORE of EVERYTHING (like offsetting the window to start before)
    [[filler] ++ Enum.take(arr, 2) | Enum.chunk_every(arr, 3, 1, [filler])]
  end

  # {sum of ahead and behind excluding item, sum of all 3 or 2}
  def neighbor_summer([a, _, c] = neighbors), do: {a + c, Enum.sum(neighbors)}

  def vertical_summer([top, mid, bot]) do
    nonmid_summer = fn {_, neighbor_sum} -> neighbor_sum end

    mid_summer = fn {mid_sum, _} -> mid_sum end

    top = Enum.map(top, nonmid_summer)
    mid = Enum.map(mid, mid_summer)
    bot = Enum.map(bot, nonmid_summer)

    List.zip([top, mid, bot])
    |> Enum.map(fn {a, b, c} -> a + b + c end)
  end

  def cell_logic({1, neighbor_count}) when neighbor_count < 2 or neighbor_count > 3, do: 0
  def cell_logic({1, _}), do: 1
  def cell_logic({0, neighbor_count}) when neighbor_count == 0, do: 1
  def cell_logic({0, _}), do: 0
end

intake = [
  [0, 0, 0, 1, 1, 0, 1, 0],
  [1, 0, 1, 0, 1, 1, 1, 0],
  [1, 0, 1, 0, 1, 0, 0, 0],
  [1, 0, 1, 0, 1, 0, 1, 0],
  [1, 0, 1, 0, 0, 0, 1, 0]
]

intake2 = [
  [1, 1, 1, 1, 0],
  [1, 1, 1, 1, 1],
  [0, 1, 1, 1, 1]
]

IO.inspect(
  intake
  |> Game.main()
  |> Game.main()
  |> Game.main()
  |> Game.main()
  |> Game.main()
  |> Game.main()
  |> Game.main()
  |> Game.main()
  |> Game.main()
  |> Game.main()
  |> Game.main()
  |> Game.main()
  |> Game.main()
)

