defmodule Servy.PledgeController do

  alias Servy.View

  def create(conv, %{"name" => name, "amount" => amount}) do
    # Sends the pledge to the external service and caches it
    Servy.PledgeServer.create_pledge(name, String.to_integer(amount))

    %{ conv | status: 201, resp_body: "#{name} pledged #{amount}!" }
  end

  def index(conv) do
    # Gets the recent pledges from the cache
    pledges = Servy.PledgeServer.recent_pledges()

    View.render(conv, "recent_pledges.eex", pledges: pledges)
  end

  def new(conv) do
    View.render(conv, "new_pledges.eex")
  end
end
