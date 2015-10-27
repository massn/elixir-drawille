defmodule DrawilleTest do
  use ExUnit.Case
  doctest Drawille
  import Drawille.Canvas

  test "set and unset" do
    random_x = :rand.uniform(100)
    random_y = :rand.uniform(100)
    canvas =
    new
    |> set(random_x, random_y)
    |> unset(random_x, random_y)
    assert %Drawille.Canvas{chars: %{}} = canvas
  end

end
