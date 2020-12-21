defmodule GridTest do
  use ExUnit.Case
  # import Day20
  import Day20.Grid

  setup_all do
    strs = [
      "#..",
      ".#.",
      "..#"
    ]

    grid = from_strs(strs)

    {:ok, grid: grid, strs: strs}
  end

  test "from_rows", state do
    grid = from_rows([
      ["#", ".", "."],
      [".", "#", "."],
      [".", ".", "#"]
    ])
    assert grid.x_max == 2
    assert grid.y_max == 2
    assert grid.grid_map == %{
      {0, 0} => "#",
      {0, 1} => ".",
      {0, 2} => ".",
      {1, 0} => ".",
      {1, 1} => "#",
      {1, 2} => ".",
      {2, 0} => ".",
      {2, 1} => ".",
      {2, 2} => "#"
    }
  end

  test "from_cols_simpler", state do
    grid = from_cols([
      ["#", "."],
      ["#", "."],
      ["#", "#"]
    ])


    assert grid.x_max == 2
    assert grid.y_max == 1
    assert grid.grid_map == %{
      {0, 0} => "#",
      {0, 1} => ".",
      {1, 0} => "#",
      {1, 1} => ".",
      {2, 0} => "#",
      {2, 1} => "#",
    }
  end

  test "from_cols", state do
    grid = from_cols([
      ["#", ".", "."],
      ["#", "#", "."],
      [".", "#", "#"]
    ])


    assert grid.x_max == 2
    assert grid.y_max == 2
    assert grid.grid_map == %{
      {0, 0} => "#",
      {0, 1} => ".",
      {0, 2} => ".",
      {1, 0} => "#",
      {1, 1} => "#",
      {1, 2} => ".",
      {2, 0} => ".",
      {2, 1} => "#",
      {2, 2} => "#"
    }
  end

  test "from_strs", state do
    assert state.grid.x_max == 2
    assert state.grid.y_max == 2
    assert state.grid.grid_map == %{
      {0, 0} => "#",
      {0, 1} => ".",
      {0, 2} => ".",
      {1, 0} => ".",
      {1, 1} => "#",
      {1, 2} => ".",
      {2, 0} => ".",
      {2, 1} => ".",
      {2, 2} => "#"
    }
  end

  test "to_strs", state do
    grid = state.grid

    new_strs = to_strs(grid)

    assert state[:strs] == new_strs
  end

  # test "from_vertical_strs" do

  # end

  # test "to_vertical_strs" do

  # end

  test "at", state do
    grid = state[:grid]

    assert at(state.grid, {0, 0}) == "#"
    assert at(state.grid, {0, 1}) == "."
    assert at(state.grid, {2, 2}) == "#"
  end

  test "rows", state do
    assert rows(state.grid) == [["#", ".", "."], [".", "#", "."], [".", ".", "#"]]
  end

  test "row", state do
    assert row(state.grid, 1) == [".", "#", "."]
  end

  test "cols" do
    grid = [
      "##.",
      ".#.",
      ".##"
    ] |> from_strs()

    assert cols(grid) == [["#", ".", "."], ["#", "#", "#"], [".", ".", "#"]]
  end

  test "col" do
    grid = [
      "##.",
      ".#.",
      ".##"
    ] |> from_strs()

    assert col(grid, 2) == [".", ".", "#"]
  end

  # #..
  # .#.
  # ..#
  test "flip_horiz", state do
    flipped =
      state.grid
      |> flip_horiz()
      |> to_strs()

    assert flipped == [
      "..#",
      ".#.",
      "#.."
    ]
  end

  # #..
  # .#.
  # ..#
  test "flip_vert", state do
    grid = [
      "##.",
      ".#.",
      "..#"] |> from_strs

    flipped =
      grid
      |> flip_vert()
      |> to_strs()

    assert flipped == [
      "..#",
      ".#.",
      "##."
    ]
  end

  test "rotate_90_simple", state do
    grid = [
      "**",
      ".."
    ] |> from_strs()

    rotated90 =
      grid
      |> rotate()
      |> to_strs()

    assert rotated90 = [
      ".*",
      ".*"
    ]

    rotated180 =
      grid
      |> rotate()
      |> rotate()
      |> to_strs()

    assert rotated180 = [
      "..",
      "**"
    ]

    rotated270 =
      grid
      |> rotate()
      |> rotate()
      |> rotate()
      |> to_strs()

    assert rotated270 = [
      "*.",
      "*."
    ]
  end

  test "rotated bigger" do
    grid = [
      "....#.....",
      "....#.....",
      "....#.....",
      "....#.....",
      "....######",
      "..........",
      "..........",
      "..........",
      "..........",
      "..........",
    ] |> from_strs()

    rotated90 =
      grid
      |> rotate()
      |> to_strs()

    assert rotated90 = [
      "..........",
      "..........",
      "..........",
      "..........",
      "....######",
      "....#.....",
      "....#.....",
      "....#.....",
      "....#.....",
      "....#.....",
    ]
  end
end