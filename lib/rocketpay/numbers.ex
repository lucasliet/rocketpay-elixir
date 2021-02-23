defmodule Rocketpay.Numbers do
  def sum_from_file(filename) do
    File.read("#{filename}.csv")
    |>handle_file()
  end

  defp handle_file({:error, _reason}), do: {:error, "Invalid file!"}
  defp handle_file({:ok, file}) do
    sum = file
      |>convert_to_list()
      |>convert_list_to_numbers()
      |>Enum.sum()
    {:ok, %{result: sum}}
  end
  defp convert_to_list(file), do: String.split(file, ",")
  defp convert_list_to_numbers(list), do: Enum.map(list, fn number -> String.to_integer(number) end)
end
