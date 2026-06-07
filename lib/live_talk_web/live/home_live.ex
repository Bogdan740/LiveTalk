defmodule LiveTalkWeb.HomeLive do
  use LiveTalkWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="text-8xl">

      We are in a div here
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
