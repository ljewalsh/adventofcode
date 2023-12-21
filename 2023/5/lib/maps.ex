defmodule Maps do
  def make_maps(lines) do
    {_seed_lines, map_lines} = Enum.split(lines, 2)
    create_maps_from_lines(map_lines)
  end

  defp create_maps_from_lines(lines, current_map_name \\ "", current_map \\ [], maps \\ %{})

  defp create_maps_from_lines([], current_map_name, current_map, maps) do
    Map.put(maps, current_map_name, current_map)
  end

  defp create_maps_from_lines(["" | remaining_lines], current_map_name, current_array, maps) do
    updated_maps = Map.put(maps, current_map_name, current_array)
    create_maps_from_lines(remaining_lines, current_map_name, current_array, updated_maps)
  end

  defp create_maps_from_lines([line | remaining_lines], current_map_name, current_array, maps) do
    case String.split(line, " map:") do
      [map_name, _map_suffix] ->
        create_maps_from_lines(remaining_lines, map_name, [], maps)

      [other_kind_of_line] ->
        updated_array = handle_value_line(other_kind_of_line, current_array)
        create_maps_from_lines(remaining_lines, current_map_name, updated_array, maps)
    end
  end

  defp handle_value_line(line, current_array) do
    [destination_range_start, source_range_start, range_length] = String.split(line, " ")
    current_array ++ [[destination_range_start, source_range_start, range_length]]
  end
end
