defmodule Practice.Palindrome do
 # still a palindrome even if casing doesn't match 
  def palindrome?(x) do
    String.downcase(x) === String.downcase(reverse_chars(x))
  end

#word reverse function gotten from in class code
  def reverse_chars(word) do
    word
    |> String.to_charlist
    |> Enum.reverse
    |> to_string
  end
end
