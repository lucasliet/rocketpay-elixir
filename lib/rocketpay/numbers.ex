defmodule Rocketpay.Numbers do
  def sum_from_file(filename) do
    file = file.read("#{filename}.csv")
  end
end
