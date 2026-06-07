defmodule LiveTalkWeb.ChatLive do
  use LiveTalkWeb, :live_view

  def mount(params, session, socket) do
    {:ok, socket |> assign(:username, Map.get(params, "username", "empty"))}
  end

  def render(assigns) do
    ~H"""
    <h1>You are now on the chat page, your username is: {@username}</h1>
    <div class="flex flex-col h-full">
      <div class="chat-display bg-amber-300"> This is where the chat display goes</div>
      <div class="chat-input bg-blue-700"> This is where we are gonna let the user do the input</div>
    </div>
    """
  end
end
