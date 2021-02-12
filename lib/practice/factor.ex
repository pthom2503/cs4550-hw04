defmodule Practice.Factor do
  def factor(x) do
    factor(x, [], 3)
  end

  def factor(x, acc, i) when x < 2 do
    acc
  end

  def factor(x, acc, i) when rem(x, 2) === 0 do
    factor(div(x, 2), acc ++ [2], i)
  end

  def factor(x, acc, i) when rem(x, i) === 0 do
    factor(div(x, i), acc ++ [i], i)
  end

  def factor(x, acc, i) when i > x do
    acc
  end

  def factor(x, acc, i) do
    factor(x, acc, i + 1)
  end

end
