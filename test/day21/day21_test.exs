defmodule Day21Test do
  use ExUnit.Case
  import Day21

  test "Part 1" do
    input = FileUtils.get_file_as_strings("test/day21/input.txt")
    assert Day21.part_1(input) == 2170
  end

  # test "Part 2" do
  #   input = FileUtils.get_file_as_integers("test/day21/input.txt")
  #   assert Day21.part_2(input) == 0
  # end
end