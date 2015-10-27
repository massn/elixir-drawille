defmodule Drawille.Canvas do
  @moduledoc """
  Module for still drawing.
  """

  defstruct chars: %{}, top_left: :undefined, down_right: :undefined
  use Bitwise
  alias Drawille.Canvas, as: Canvas
  alias Drawille.Braille, as: Braille

  @doc """
  Make new empty canvas.
  """
  def new, do: %Canvas{}

  @doc """
  Set a dot at (x, y) to a canvas.
  """
  def set(%{chars: chars, top_left: top_left, down_right: down_right}, x, y)
  when x > 0 and y > 0
  do
    {{chars_x, chars_y} = chars_xy, {dots_x, dots_y}} = normalize x, y
    braille_byte_to_be_set =  Braille.pixel_map(dots_x, dots_y)
    chars = case Map.fetch chars, chars_xy do
      {:ok, char0} -> Map.put(chars, chars_xy, char0 ||| braille_byte_to_be_set)
      :error -> Map.put_new(chars, chars_xy, braille_byte_to_be_set)
    end
    top_left = case top_left do
      :undefined -> chars_xy
      {top_left_x, top_left_y} -> {min(top_left_x, chars_x), min(top_left_y, chars_y)}
    end
    down_right = case down_right do
      :undefined -> chars_xy
      {down_right_x, down_right_y} -> {max(down_right_x, chars_x), max(down_right_y, chars_y)}
    end
    %Canvas{
      chars: chars,
      top_left: top_left,
      down_right: down_right}
  end
  def set(_, x, y) do
    raise("x(#{x}) and y(#{y}) must be positive.")
  end

  @doc """
  Unset a dot at (x, y) from a canvas.
  """
  def unset(canvas = %{chars: chars}, x, y)
  when x > 0 and y > 0
  do
    {chars_xy, {dots_x, dots_y}} = normalize x, y
    braille_byte_to_be_unset =  Braille.pixel_map(dots_x, dots_y)
    chars = case Map.fetch chars, chars_xy do
      {:ok, char0} ->
        case char0 &&& braille_byte_to_be_unset do
          0 -> chars
          _ ->
            case bxor(char0, braille_byte_to_be_unset) do
              0 -> Map.delete(chars, chars_xy)
              new_char -> Map.put(chars, chars_xy, new_char)
            end
        end
      :error -> chars
    end
    %{canvas | chars: chars}
  end

  @doc """
  Draw a canvas.
  """
  def frame %{chars: chars, top_left: {tl_x, tl_y}, down_right: {dr_x, dr_y}} do
    frame_string =
    for y <- tl_y .. dr_y,
        x <- tl_x .. dr_x,
        into: ""
    do
      char =
      case Map.fetch chars, {x, y} do
        {:ok, char} -> char
        :error -> 0
      end
      code = Braille.to_utf8_code char
      string = <<code :: utf8>>
      if x == dr_x do
        string <> "\n"
      else
        string
      end
    end
    IO.puts frame_string
  end

  defp normalize x, y do
    rounded_x = Kernel.round x
    rounded_y = Kernel.round y
    chars_x = div rounded_x, 2
    chars_y = div rounded_y, 4
    dots_x = rem rounded_x, 2
    dots_y = rem rounded_y, 4
    {{chars_x, chars_y}, {dots_x, dots_y}}
  end

end

