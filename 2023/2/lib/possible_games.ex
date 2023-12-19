defmodule PossibleGames do
  def find_possible_games do
    known_cubes = %{"red" => 12, "green" => 13, "blue" => 14}

    get_lines_in_file("./games.txt")
    |> Enum.map(fn line -> get_game_value(line, known_cubes) end)
    |> Enum.sum()
  end

  def get_lines_in_file(file) do
    File.stream!(file)
    |> Stream.map(&String.trim_trailing/1)
  end

  def get_game_value(game, known_cubes) do
    [game_id_string, turns] = String.split(game, ": ")
    game_turns = String.split(turns, "; ")

    case turns_are_possible(game_turns, known_cubes) do
      true -> get_game_id(game_id_string)
      false -> 0
    end
  end

  def get_game_id(game) do
    with [_game_suffice, game_id] <- String.split(game, "Game "),
         {game_id_as_integer, _} <- Integer.parse(game_id) do
      game_id_as_integer
    else
      _ -> 0
    end
  end

  def turns_are_possible([], _known_cubes) do
    true
  end

  def turns_are_possible([next_turn | remaining_turns], known_cubes) do
    cubes = String.split(next_turn, ", ")

    case turn_is_possible(cubes, known_cubes) do
      true -> turns_are_possible(remaining_turns, known_cubes)
      false -> false
    end
  end

  def turn_is_possible([], known_cubes) do
    true
  end

  def turn_is_possible([cube | remaining_cubes], known_cubes) do
    with [number, color] <- String.split(cube, " "),
         {parsed_number, _} <- Integer.parse(number),
         known_number <- Map.get(known_cubes, color),
         true <- parsed_number <= known_number do
      turn_is_possible(remaining_cubes, known_cubes)
    else
      _ -> false
    end
  end
end
