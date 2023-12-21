defmodule Locations do
  def get_locations_for_seeds(_seeds_, _map, _locations \\ [])

  def get_locations_for_seeds([], _map, locations) do
    locations
  end

  def get_locations_for_seeds([next_seed | remaining_seeds], map, locations) do
    soil_value = get_maps_from_map(next_seed, "seed-to-soil", map)
    fertilizer_value = get_maps_from_map(soil_value, "soil-to-fertilizer", map)
    water_value = get_maps_from_map(fertilizer_value, "fertilizer-to-water", map)
    light_value = get_maps_from_map(water_value, "water-to-light", map)
    temperature_value = get_maps_from_map(light_value, "light-to-temperature", map)
    humidity_value = get_maps_from_map(temperature_value, "temperature-to-humidity", map)
    location_value = get_maps_from_map(humidity_value, "humidity-to-location", map)
    {location_value_parsed, _} = Integer.parse(location_value)
    get_locations_for_seeds(remaining_seeds, map, locations ++ [location_value_parsed])
  end

  def get_maps_from_map(key, map_name, map) do
    maps = Map.get(map, map_name)
    find_value(maps, key)
  end

  def find_value([], key) do
    key
  end

  def find_value([next_map | remaining_maps], key) do
    [destination, source, length] = next_map

    {source_parsed, _} = Integer.parse(source)
    {destination_parsed, _} = Integer.parse(destination)
    {length_parsed, _} = Integer.parse(length)
    {key_parsed, _} = Integer.parse(key)

    max_length = source_parsed + length_parsed

    case key_parsed >= source_parsed && key_parsed <= max_length do
      true ->
        difference = key_parsed - source_parsed
        Integer.to_string(destination_parsed + difference)

      false ->
        find_value(remaining_maps, key)
    end
  end
end
