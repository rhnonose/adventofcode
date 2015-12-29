defmodule NiceNaughtyTest do
  use ExUnit.Case
  doctest NiceNaughty

  test "at least three vowels" do
    assert  NiceNaughty.has_three_vowels("jfmthnfrtncutdie")
    assert  NiceNaughty.has_three_vowels("jfmthnfrtucutdie")
    assert  NiceNaughty.has_three_vowels("jaethnfrtucutdie")
    assert !NiceNaughty.has_three_vowels("zztdcqzqddaazdjp")
  end

  test "at least one letter in a row" do
    assert  NiceNaughty.has_consecutive_letters("eytquncjituzzhsx")
    assert  NiceNaughty.has_consecutive_letters("dtfkgggvqadhqbwb")
    assert  NiceNaughty.has_consecutive_letters("zettygjpcoedwyio")
    assert  NiceNaughty.has_consecutive_letters("xobfthcuuzhvhzpn")
    assert !NiceNaughty.has_consecutive_letters("dhfespzrhecigzqb")
    assert !NiceNaughty.has_consecutive_letters("arsvmfznblsqngvb")
    assert !NiceNaughty.has_consecutive_letters("iyphmphgntinfezg")
    assert !NiceNaughty.has_consecutive_letters("cgpaqjvzhbumckwo")
  end

  test "doesn't contain ab|cd|pq|xy" do
    assert !NiceNaughty.has_some_strings("vxrkhvglynljgqrg")
    assert !NiceNaughty.has_some_strings("bugepxgpgahtsttl")
    assert NiceNaughty.has_some_strings("odclumkenabcsfzr")
    assert NiceNaughty.has_some_strings("anoqkkbcdropskhj")
    assert NiceNaughty.has_some_strings("xycjvvsuaxsbrqal")
    assert NiceNaughty.has_some_strings("zufmkmuujavcskpq")
  end

  test "string is nice" do
    func = NiceNaughty.is_nice
    assert  func.("aaa")
    assert  func.("ugknbfddgicrmopn")
  end

  test "string is naughty" do
    func = NiceNaughty.is_nice
    assert !func.("haegwjzuvuyypxyu")
    assert !func.("jchzalrnumimnmhp")
    assert !func.("dvszwmarrgswjxmb")
  end
  end
end
