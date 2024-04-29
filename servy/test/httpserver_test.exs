defmodule HTTPServerTest do
  use ExUnit.case

  alias Servy.HttpServer
  alias Servy.HttpClient

  test "accepts a request on a socket and sends back a response" do
    spawn(HttpServer, :start, [4000])

    urls = [
      "http://localhost:4000/wildthings",
      "http://localhost:4000/bears",
      "http://localhost:4000/bears/1",
      "http://localhost:4000/wildlife",
      "http://localhost:4000/api/bears"
    ]

    urls
    |> Enum.map(&Task.async(fn -> HttPoison.get(&1) end))
    |> Enum.map(&Task.await/1)
    |> Enum.map(&assert_successful_response)

    defp assert_successful_response({:ok, response}) do
      assert response.status_code == 200
    end
  end
end
