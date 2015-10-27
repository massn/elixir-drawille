defmodule Drawille.Braille do
  @moduledoc """
  Module for a braille code.
  """
  @braille_offset 0x2800

  @doc """
   You can get "braille byte" by pixel_map.

   pixel map to n-th bits:

   |   |x=0|x=1|
   |-- |-- |-- |
   |y=0| 1 | 4 |
   |y=1| 2 | 5 |
   |y=2| 3 | 6 |
   |y=3| 7 | 8 |

  """

  def pixel_map(0, 0), do: 0x01
  def pixel_map(1, 0), do: 0x08
  def pixel_map(0, 1), do: 0x02
  def pixel_map(1, 1), do: 0x10
  def pixel_map(0, 2), do: 0x04
  def pixel_map(1, 2), do: 0x20
  def pixel_map(0, 3), do: 0x40
  def pixel_map(1, 3), do: 0x80

  @doc """
  Get a printable UTF8 code.
  """
  def to_utf8_code(0), do: @braille_offset
  def to_utf8_code braille_byte do
    braille_byte + @braille_offset
  end
end

