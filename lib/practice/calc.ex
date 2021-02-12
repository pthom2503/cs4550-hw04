defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def tag(x) do
    case x do
      "+" -> {:op, "+"}
      "-" -> {:op, "-"}
      "*" -> {:op, "*"}
      "/" -> {:op, "/"}
      _ -> {:num, parse_float(x)}
    end
  end

  def precedence(op) do
    case op do
      {:op, "+"} -> 1
      {:op, "-"} -> 1
      {:op, "*"} -> 2
      {:op, "/"} -> 2
    end
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    # inputs are expected to be separated by spaces, but because of typecasting in elixir, numbers with symbols immediately to their right will drop the malformed symbols
    expr
    |> String.split(~r/\s+/)
    |> Enum.map(&tag/1)
    |> to_postfix([], []) 
    |> handle_postfix([])
  end

  def to_postfix([], postfix_list, op_stack) do
    Enum.reverse(postfix_list) ++ op_stack
  end

  def to_postfix([{:num, x} | tail], postfix_list, op_stack) do
    to_postfix(tail, [{:num, x} | postfix_list], op_stack)
  end

  def to_postfix([{:op, x} | tail], postfix_list, op_stack) do
    op_helper(tail, x, postfix_list, op_stack)
  end

  def op_helper(infix_list, x, postfix_list, []) do
    to_postfix(infix_list, postfix_list, [{:op, x}])
  end

  def op_helper(infix_list, x, postfix_list, [op_head | op_tail] = op_stack) do
    if precedence({:op, x}) > precedence(op_head) do
      to_postfix(infix_list, postfix_list, [{:op, x} | op_stack])
    else
      op_helper(infix_list, x, [op_head | postfix_list], op_tail) 
    end
  end

  def handle_postfix([], [result]) do
    result
  end

  def handle_postfix([{:num, x} | tail], number_stack) do
    handle_postfix(tail, [x | number_stack])
  end

  def handle_postfix([{:op, x} | tail], [y, z | number_tail]) do
    case x do
      "+" -> handle_postfix(tail, [z + y | number_tail])
      "-" -> handle_postfix(tail, [z - y | number_tail])
      "*" -> handle_postfix(tail, [z * y | number_tail])
      "/" -> handle_postfix(tail, [z / y | number_tail])
      _ -> "Bad. Invalid operation"
    end
  end

  def handle_postfix(_, _) do
    "Invalid input"
  end


end
