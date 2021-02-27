defmodule Rocketpay.Numbers do
  def sum_from_file(filename) do
    "#{filename}.csv"
    |> File.read()
    |> handle_file()
  end

  # Abaixo, usamos o Pattern Matching.
  # A primeira função só será executada se o que ela recebe como parâmetro
  # "dá match" que está definido nela.

  # Usando syntax sugar (definir a função em uma única linha)
  defp handle_file({:ok, result}) do
    result =
    result
    |> String.split(",")
    |> Stream.map(fn char -> String.to_integer(char) end)
    |> Enum.sum()

    {:ok, %{result: result}}
  end
  # Ignorando o segundo parâmetro usando o "_"
  defp handle_file({:error, _reason}), do: {:error, %{message: "File not found."}}

end
