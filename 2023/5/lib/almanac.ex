defmodule Almanac do
  def solve do
    file_stream = get_lines_in_file("./input.txt")
    lines = Enum.map(file_stream, fn line -> line end)
    seeds = get_seeds(lines)
    maps = Maps.make_maps(lines)
    locations = Locations.get_locations_for_seeds(seeds, maps)
    Enum.min(locations)
  end

  def get_lines_in_file(file) do
    File.stream!(file)
    |> Stream.map(&String.trim_trailing/1)
  end

  defp get_seeds(lines) do
    seed_line = Enum.at(lines, 0)
    [_suffix, seeds_string] = String.split(seed_line, "seeds: ")
    String.split(seeds_string, " ")
  end
end
