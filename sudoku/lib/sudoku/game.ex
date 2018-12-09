defmodule Sudoku.Game do
  # To-Do:
  # Generate board function
  # Check board function
  #   contains: check column, check row, check group

  # put move
  # print board

  # Useful lower-level commands so far:
  # board = Sudoku.Game.new_game()
  # board = Sudoku.Game.add_move(board, "A9", 2)
  # Sudoku.Game.print_board(board)

  def new_game() do
    # To-do:
    instantiate_board()
    |> generate_puzzle()
  end

  # The gist of the general algorithm:
  #   1. Assumption: Given the rules of sudoku, given a 9x9 board that can be broken up
  #      into 3x3 segments, the first 3 diagonal 3x3 segments can be randomly generated with numbers 1-9
  #      with no collisions.
  #   2. After the first 3 3x3 diagonal segments are generated, randomly populate each other 3x3 segment
  #      in the board. At each individual square, check to see if there are column collisions or row collisions.
  #   3. Remove elements to complete the "puzzle". There are smart ways to do this and dumb ways to do this.

  # Next steps:
  # 1. Add validation to the "add move" that can't overwrite original generated values
  # 2. Perhaps create a game struct that contains the board.
  # 3. Add concurrency
  # 4. Create GUI for webapp

    @row_mapping %{:A=>0, :B=>1, :C=>2, :D=>3, :E=>4, :F=>5, :G=>6, :H=>7, :I=>8}
    @rows         ["A", "B", "C", "D", "E", "F", "G", "H", "I"]
    @columns      ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

  def generate_puzzle(board) do
    instantiate_board()
  end

  def check_valid_move(board, coord, move) do
  end

  def check_column(board, coord, move) do

  end

  def check_row(board, coord, move) do
    [r, c] = coord
    |> String.capitalize()
    |> String.codepoints()
    row = r |> String.to_atom

    list_row = []

    for col <- @columns do
      list_row.append(board[row][col])
      IO.puts()
    end

    IO.puts("#{row}: #{board[row]["1"]} #{board[row]["2"]} #{board[row]["3"]} #{board[row]["4"]} #{board[row]["5"]} #{board[row]["6"]} #{board[row]["7"]} #{board[row]["8"]} #{board[row]["9"]}")
  end

  def check_group(board, coord, move) do

  end

  # If every value is non-zero, then check for a win.
  def check_win(board) do

  end


  # To-do with add move:
  # once check_group, check_row, and check_column is implemented, integrate this into validity checking
  # for add_move.

  def add_move(board, coord, move) do
    valid_coord = coord
    |> String.match?(~r/[a-iA-I][1-9]$/)

    valid_move = move
    |> Integer.to_string
    |> String.match?(~r/[1-9]$/)

    board
    |> try_move(coord, move, valid_coord, valid_move)
  end

  # Regex: // ~r/[A-I][1-9]/
  def try_move(board, coord, move, true, true) do
    [r, c] = coord
    |> String.capitalize()
    |> String.codepoints()
    row = r |> String.to_atom
    Kernel.put_in(board[row][c], move)
  end

  def try_move(_board, _string, _move, false, true) do
    IO.puts("Invalid coordinate placement!")
    :invalid_coord
  end

  def try_move(_board, _string, _move, true, false) do
    IO.puts("Invalid value!")
    :invalid_value
  end

  def try_move(_board, _string, _move, _valid_coord, _valid_move) do
    IO.puts("Invalid coordinate placement and value!")
    :invalid_both
  end

  def instantiate_board() do
    for _ <- 0..9, do: (for _ <- 0..8, do: 0)
  end

  # _board = %{
    #   A: %{"1" => 0, "2" => 0, "3" => 0,   "4" => 0, "5" => 0, "6" => 0,   "7" => 0, "8" => 0, "9" => 0},
    #   B: %{"1" => 0, "2" => 0, "3" => 0,   "4" => 0, "5" => 0, "6" => 0,   "7" => 0, "8" => 0, "9" => 0},
    #   C: %{"1" => 0, "2" => 0, "3" => 0,   "4" => 0, "5" => 0, "6" => 0,   "7" => 0, "8" => 0, "9" => 0},

    #   D: %{"1" => 0, "2" => 0, "3" => 0,   "4" => 0, "5" => 0, "6" => 0,   "7" => 0, "8" => 0, "9" => 0},
    #   E: %{"1" => 0, "2" => 0, "3" => 0,   "4" => 0, "5" => 0, "6" => 0,   "7" => 0, "8" => 0, "9" => 0},
    #   F: %{"1" => 0, "2" => 0, "3" => 0,   "4" => 0, "5" => 0, "6" => 0,   "7" => 0, "8" => 0, "9" => 0},

    #   G: %{"1" => 0, "2" => 0, "3" => 0,   "4" => 0, "5" => 0, "6" => 0,   "7" => 0, "8" => 0, "9" => 0},
    #   H: %{"1" => 0, "2" => 0, "3" => 0,   "4" => 0, "5" => 0, "6" => 0,   "7" => 0, "8" => 0, "9" => 0},
    #   I: %{"1" => 0, "2" => 0, "3" => 0,   "4" => 0, "5" => 0, "6" => 0,   "7" => 0, "8" => 0, "9" => 0},
    # }

  def get_val(board, coord) do
    [r, c] = coord |> coord_split

    board
    |> Enum.at(@row_mapping[r])
    |> Enum.at(c)
  end

  def coord_split(coord) do
    [r, c] = coord
    |> String.capitalize()
    |> String.codepoints()
    #row = r |> String.to_atom
    [r |> String.to_atom, (c |> String.to_integer) - 1]
  end

  # Utility function for printing board on command line (to see if my stuff is working)
  def print_board(board) do
    # IO.puts("     1 2 3   4 5 6   7 8 9  ")
    # IO.puts("   -------------------------")
    # for row <- @rows do
    #   for col <- @columns do
    #     IO.write( board |> get_val( Enum.join([row, col]) ) )
    #   end
    #   IO.puts("")
    # end

    # This is the ugly way of doing it woops
    IO.puts(
      "
           1 2 3   4 5 6   7 8 9
         -------------------------
       A | #{get_val(board, "A1")} #{get_val(board, "A2")} #{get_val(board, "A3")} | #{get_val(board, "A4")} #{get_val(board, "A5")} #{get_val(board, "A6")} | #{get_val(board, "A7")} #{get_val(board, "A8")} #{get_val(board, "A9")} |
       B | #{get_val(board, "B1")} #{get_val(board, "B2")} #{get_val(board, "B3")} | #{get_val(board, "B4")} #{get_val(board, "B5")} #{get_val(board, "B6")} | #{get_val(board, "B7")} #{get_val(board, "B8")} #{get_val(board, "B9")} |
       C | #{get_val(board, "C1")} #{get_val(board, "C2")} #{get_val(board, "C3")} | #{get_val(board, "C4")} #{get_val(board, "C5")} #{get_val(board, "C6")} | #{get_val(board, "C7")} #{get_val(board, "C8")} #{get_val(board, "C9")} |
         --------+-------+--------
       D | #{get_val(board, "D1")} #{get_val(board, "D2")} #{get_val(board, "D3")} | #{get_val(board, "D4")} #{get_val(board, "D5")} #{get_val(board, "D6")} | #{get_val(board, "D7")} #{get_val(board, "D8")} #{get_val(board, "D9")} |
       E | #{get_val(board, "E1")} #{get_val(board, "E2")} #{get_val(board, "E3")} | #{get_val(board, "E4")} #{get_val(board, "E5")} #{get_val(board, "E6")} | #{get_val(board, "E7")} #{get_val(board, "E8")} #{get_val(board, "E9")} |
       F | #{get_val(board, "F1")} #{get_val(board, "F2")} #{get_val(board, "F3")} | #{get_val(board, "F4")} #{get_val(board, "F5")} #{get_val(board, "F6")} | #{get_val(board, "F7")} #{get_val(board, "F8")} #{get_val(board, "F9")} |
         --------+-------+--------
       G | #{get_val(board, "G1")} #{get_val(board, "G2")} #{get_val(board, "G3")} | #{get_val(board, "G4")} #{get_val(board, "G5")} #{get_val(board, "G6")} | #{get_val(board, "G7")} #{get_val(board, "G8")} #{get_val(board, "G9")} |
       H | #{get_val(board, "H1")} #{get_val(board, "H2")} #{get_val(board, "H3")} | #{get_val(board, "H4")} #{get_val(board, "H5")} #{get_val(board, "H6")} | #{get_val(board, "H7")} #{get_val(board, "H8")} #{get_val(board, "H9")} |
       I | #{get_val(board, "I1")} #{get_val(board, "I2")} #{get_val(board, "I3")} | #{get_val(board, "I4")} #{get_val(board, "I5")} #{get_val(board, "I6")} | #{get_val(board, "I7")} #{get_val(board, "I8")} #{get_val(board, "I9")} |
         -------------------------
      "
    )
  end





end
