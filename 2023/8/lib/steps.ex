defmodule Steps do
  def solve() do
    file_stream = get_lines_in_file("input.txt")
    [directions_string | [_ | network_lines]] = Enum.map(file_stream, fn line -> line end)
    directions = String.split(directions_string, "", trim: true)
    network = create_network(network_lines)
    find_number_of_steps(0, "AAA", network, directions)
  end

  def find_number_of_steps(steps, "ZZZ", network, directions) do
    steps
  end

  def find_number_of_steps(steps, current_step, network, directions) do
    direction_index = rem(steps, length(directions))
    direction = Enum.at(directions, direction_index)
    [left_value, right_value] = network[current_step]

    case direction do
      "L" -> find_number_of_steps(steps + 1, left_value, network, directions)
      "R" -> find_number_of_steps(steps + 1, right_value, network, directions)
    end
  end

  def create_network(_lines, network \\ %{})

  def create_network([], network) do
    network
  end

  def create_network([next_line | remaining_lines], network) do
    [key, values_string] = String.split(next_line, " = ", trim: true)
    cleaned_values_string = String.slice(values_string, 1, String.length(values_string) - 2)
    values = String.split(cleaned_values_string, ", ")
    updated_network = Map.put(network, key, values)
    create_network(remaining_lines, updated_network)
  end

  def get_lines_in_file(file) do
    File.stream!(file)
    |> Stream.map(&String.trim_trailing/1)
  end
end
