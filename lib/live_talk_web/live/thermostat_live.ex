defmodule LiveTalkWeb.ThermostatLive do
  use LiveTalkWeb, :live_view

  def render(assigns) do
    ~H"""
    Current temperature: {@temperature}°F
    <button phx-click="inc_temperature">+</button>
    """
  end

  def mount(params, _session, socket) do
    # Let's assume a fixed temperature for now
    temperature = 70

    inspect(params)

    {:ok,
     socket
     |> assign(:temperature, temperature)}
  end

  def handle_event("inc_temperature", _params, socket) do
    {:noreply, update(socket, :temperature, &(&1 + 1))}
  end
end
