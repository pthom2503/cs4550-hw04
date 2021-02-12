defmodule Practice.Palindrome do
  
  def palindrome?(x) do
    x === reverse_chars(x)
  end

#word reverse function gotten from in class code
  def reverse_chars(word) do
    word
    |> String.to_charlist
    |> Enum.reverse
    |> to_string
  end
end
