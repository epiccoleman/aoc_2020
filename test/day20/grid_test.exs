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

  test "from_rows" do
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

  test "from_cols_simpler" do
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

  test "from_cols" do
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

  test "at", state do
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
  test "flip_vert" do
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

  test "rotate_90_simple" do
    grid = [
      "**",
      ".."
    ] |> from_strs()

    rotated90 =
      grid
      |> rotate()
      |> to_strs()

    assert rotated90 == [
      ".*",
      ".*"
    ]

    rotated180 =
      grid
      |> rotate()
      |> rotate()
      |> to_strs()

    assert rotated180 == [
      "..",
      "**"
    ]

    rotated270 =
      grid
      |> rotate()
      |> rotate()
      |> rotate()
      |> to_strs()

    assert rotated270 == [
      "*.",
      "*."
    ]
  end

  test "rotated bigger" do
    grid = [
      "##########",
      ".........#",
      ".........#",
      ".........#",
      ".........#",
      ".........#",
      ".........#",
      ".........#",
      ".........#",
      ".........#",
    ] |> from_strs()

    rotated90 =
      grid
      |> rotate()
      |> to_strs()

    assert rotated90 == [
      ".........#",
      ".........#",
      ".........#",
      ".........#",
      ".........#",
      ".........#",
      ".........#",
      ".........#",
      ".........#",
      "##########",
    ]
  end

  test "trim_edges" do
    grid = [
      "####",
      "#.##",
      "##.#",
      "####"
      ] |> from_strs

    trimmed =
      grid
      |> trim_edges()
      |> to_strs()

    assert trimmed == [
      ".#",
      "#."
    ]
  end

  test "edges" do
    grid = [
      "#.#.",
      "#..#",
      "#..#",
      "#..#"
    ] |> from_strs

    assert left_edge(grid) == ["#","#","#","#"]
    assert right_edge(grid) == [".","#","#","#"]
    assert top_edge(grid) == ["#",".","#","."]
    assert bottom_edge(grid) == ["#",".",".","#"]
  end

  test "orient_edge_top" do
    grid = [
      "#.#.",
      "#..#",
      "#..#",
      "#..#"
    ] |> from_strs

    reoriented =
      grid
      |> orient_edge_top(["#","#","#","."])
      |> to_strs()

    assert reoriented == [
      "###.",
      "...#",
      "....",
      "####"
    ]
  end

  test "orient_edge_to_direction" do
    grid = [
      "#.#.",
      "#..#",
      "#..#",
      "#..#"
    ] |> from_strs

    reoriented =
      grid
      |> orient_edge_to_direction(["#",".","#","."], :right)
      |> to_strs()

    assert reoriented == [
      "####",
      "....",
      "...#",
      "###."
    ]
  end

  test "append_grid" do
    grid = [
      "#.#.",
      "#..#",
      "#..#",
      "#..#"
    ] |> from_strs

    appended = append_grid(grid, grid) |> to_strs()

    assert appended == [
      "#.#.#.#.",
      "#..##..#",
      "#..##..#",
      "#..##..#"
    ]
  end
end
