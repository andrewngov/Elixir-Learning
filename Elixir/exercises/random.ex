defmodule Random do
  add = fn(a, b) -> a + b end
  add = &(&1 + &2)

  repeat = &String.duplicate(&1, &2)
  repeat = &String.duplicate/2

  ranks =
    [ "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A" ]

  suits =
    [ "♣", "♦", "♥", "♠" ]

  deck = for suit <- suits, rank <- ranks, do: {rank, suit}

  deal13 = deck |> Enum.shuffle |> Enum.take(13) |> IO.inspect
  fourhandsof13 = Enum.shuffle |> Enum.chunk_every(13) |> IO.inspect

  def client(http) do
    some_host_in_net = 'localhost' #to make it runnable on one machine
    {:ok, socket} = :gen_tcp.connect(some_host_in_net, 4000, [binary, packet: :raw, active: false])
    :ok = :gen_tcp.send(socket, request)
    {:ok, response} = :gen_tcp.recv(socket, 0)
    :ok = :gen_tcp.close(socket)
    response
  end

  request = """
    GET /bears HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

  spawn(fn -> Servy.HttpServer.start(4000) end)

  response = Servy.HttpClient.send_request(request)
  IO.puts response
end
