defmodule LiveViewStudioWeb.LightLive do
  use LiveViewStudioWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, brightness: 10, temp: "3000")
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Front Proch Light</h1>
    <div id="light" phx-window-keyup="update">
      <div class="meter">
        <span style={"width: #{@brightness}%; background: #{temp_color(@temp)}"}>
          <%= @brightness %>%
        </span>
      </div>
      <button phx-click="off">
        <img src="/images/light-off.svg">
      </button>
      <button phx-click="down">
        <img src="/images/down.svg">
      </button>
      <button phx-click="up">
        <img src="/images/up.svg">
      </button>
      <button phx-click="on">
        <img src="/images/light-on.svg">
      </button>
      <button phx-click="rando">
        <img src="/images/fire.svg">
      </button>

      <form phx-change="change-temp">
        <div class="temps">
          <%= for temp <- ["3000", "4000", "5000"] do %>
            <div>
              <input type="radio" id={temp} name="temp" value={temp} phx-debounce="250"
              checked={temp == @temp} />
              <label for={temp}><%= temp %></label>
            </div>
          <% end %>
        </div>
      </form>

      <form phx-change="update">
        <input type="range" min="0" max="100"
          name="brightness" value={@brightness} />
      </form>
    </div>
    """
  end

  def handle_event("update", %{"key" => "ArrowUp"}, socket) do
    {:noreply, brightness_up(socket)}
  end

  def handle_event("update", %{"key" => "ArrowDown"}, socket) do
    {:noreply, brightness_down(socket)}
  end

  def handle_event("update", _, socket), do: {:noreply, socket}

  defp brightness_up(socket) do
    update(socket, :brightness, &min(&1 + 10, 100))
  end

  defp brightness_down(socket) do
    update(socket, :brightness, &max(&1 - 10, 0))
  end

  def handle_event("on", _, socket) do
    socket = assign(socket, brightness: 100)
    {:noreply, socket}
  end

  def handle_event("off", _, socket) do
    socket = assign(socket, brightness: 0)
    {:noreply, socket}
  end

  def handle_event("down", _, socket) do
    socket = update(socket, :brightness, &max(&1 - 10, 0))
    {:noreply, socket}
  end

  def handle_event("up", _, socket) do
    socket = update(socket, :brightness, &min(&1 + 10, 100))
    {:noreply, socket}
  end

  def handle_event("rando", _, socket) do
    socket = assign(socket, brightness: Enum.random(0..100))
    {:noreply, socket}
  end

  def handle_event("update", %{"brightness" => brightness}, socket) do
    socket = assign(socket, brightness: String.to_integer(brightness))
    {:noreply, socket}
  end

  def handle_event("change-temp", %{"temp" => temp}, socket) do
    socket = assign(socket, temp: temp)
    {:noreply, socket}
  end

  defp temp_color("3000"), do: "#F1C40D"
  defp temp_color("4000"), do: "#FEFF66"
  defp temp_color("5000"), do: "#99CCFF"
end
