defmodule BananaBank.ViaCep.Client do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://viacep.com.br/ws"
  plug Tesla.Middleware.JSON

  def call(cep) do
    "/#{cep}/json/"
    |> get()
    |> handle_response()
  end

  defp handle_response({:error, _raison}), do: {:error, :internal_server_error}

  defp handle_response({:ok, %Tesla.Env{status: 400}}) do
    {:error, :bad_request}
  end

  defp handle_response({:ok, %Tesla.Env{status: 200, body: %{"erro" => true}}}) do
    {:error, :resource_not_found, "cep não encontrado"}
  end

  defp handle_response({:ok, %Tesla.Env{status: 200, body: body}}) do
    {:ok, body}
  end
end
