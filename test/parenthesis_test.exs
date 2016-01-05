defmodule ParenthesisTest do
  use ExUnit.Case
  doctest Parenthesis

  test "two two" do
    assert Parenthesis.find_parenthesis(String.codepoints("()()"), 0) == 0
  end

  test "3" do
    assert Parenthesis.find_parenthesis(String.codepoints("((("), 0) == 3
  end

  test "5 2" do
    assert Parenthesis.find_parenthesis(String.codepoints("(()(()("), 0) == 3
  end

  test "2 5" do
    assert Parenthesis.find_parenthesis(String.codepoints("))((((("), 0) == 3
  end

  test "1 2" do
    assert Parenthesis.find_parenthesis(String.codepoints("())"), 0) == -1
  end

  test "2 5 alternate" do
    assert Parenthesis.find_parenthesis(String.codepoints(")())())"), 0) == -3
  end

  test "immediately enter basement" do
    assert Parenthesis.find_position(String.codepoints(")"), 0, 0) == 1
  end

  test "enter basement after some juggling" do
    assert Parenthesis.find_position(String.codepoints("()())"), 0, 0) == 5
  end

  test "ignore the rest of the walking" do
    assert Parenthesis.find_position(String.codepoints("(())())((((((((("), 0, 0) == 7
  end
end
