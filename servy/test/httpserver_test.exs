defmodule HTTPServerTest do
  use ExUnit.case

  alias Servy.HttpServer
  alias Servy.HttpClient

  test "accepts a request on a socket and sends back a response" do
    spawn(HttpServer, :start, [4000])

    parent = self()

    #Spawn client processes
    for _ <- 1..5 do
      spawn(fn ->
        #Send request
        {:ok, response} = HTTPoison.get "http://localhost:4000/wildthings"

        #Send response back to parent
        send(parent, {:ok, response})
      end)
    end

    #Await all messages from spawned processes
    for _ <- 1..5 do
      receive do
        {:ok, response} ->
          assert response.status_code == 200
          assert response.body == "Bears, Lions, Tigers"
      end
    end
  end
end
