defmodule Drawille.Examples.Circular do
  @moduledoc"""
  Example codes using circular functions.
  """
  import Drawille.Canvas

  @doc"""
  Make sine a sine curve.
  """
  def test1 do
    Enum.reduce(1..160, new,
       fn(x, acc_canvas) ->
         y = :math.sin(x * 0.05) * 20 + 30
         set(acc_canvas, x, y)
       end)
  |> frame
  end

  @doc"""
  Make a circle.
  """
  def test2 do
    n = 200
    Enum.reduce(1..n, new,
       fn(t, acc_canvas) ->
         theta = 2 * :math.pi * (t/200)
         x = 30 * :math.cos(theta) + 40
         y = 30 * :math.sin(theta) + 40
         set(acc_canvas, x, y)
       end)
    |> frame
  end
end
