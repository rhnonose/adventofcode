defmodule FireHazardTest do
  use ExUnit.Case
  doctest FireHazard

  test "parse on command" do
    {:on,from,to} = FireHazard.parse_command("turn on 489,959 through 759,964")
    assert from == {489,959}
    assert to   == {759,964}
  end

  test "parse off command" do
    {:off,from,to} = FireHazard.parse_command("turn off 82,516 through 871,14")
    assert from == {82,516}
    assert to   == {871,14}
  end

  test "parse toggle command" do
    {:toggle,from,to} = FireHazard.parse_command("toggle 756,965 through 812,992")
    assert from == {756,965}
    assert to   == {812,992}
  end

  test "process command on" do
    func = FireHazard.process_command
    ret = func.({:on,{0,0},{1,1}}, [])
    assert Enum.sort(ret) == [{0,0},{0,1},{1,0},{1,1}]
  end

  test "process command off" do
    func = FireHazard.process_command
    ret = func.({:off,{0,0},{1,1}}, [{0,0},{0,1},{1,0},{1,1}])
    assert ret == []
  end

  test "process command toggle" do
    func = FireHazard.process_command
    ret = func.({:toggle,{1,1},{2,2}}, [{0,0},{0,1},{1,0},{1,1}])
    assert Enum.sort(ret) == [{0,0},{0,1},{1,0},{1,2},{2,1},{2,2}]
  end

  test "format commands" do
    {:on, {489,959}, {759,964}} = FireHazard.format_command("489,959 through 759,964", :on)
    {:off, {820,516}, {871,914}} = FireHazard.format_command("820,516 through 871,914", :off)
    {:toggle, {217,605}, {961,862}} = FireHazard.format_command("217,605 through 961,862", :toggle)
  end

  test "generate lines" do
    lines = FireHazard.generate_lines(0,0,4)
    assert Enum.sort(lines) == [{0,0}, {1,0}, {2,0}, {3,0}, {4,0}]
  end

  test "generate columns" do
    columns = FireHazard.generate_columns({0,0},{2,2})
    assert Enum.sort(columns) == [{0,0}, {0,1}, {0,2}, {1,0}, {1,1}, {1,2}, {2,0}, {2,1}, {2,2}]
  end

end
