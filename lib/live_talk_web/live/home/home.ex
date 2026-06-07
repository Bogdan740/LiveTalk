defmodule LiveTalkWeb.HomeLive do
  use LiveTalkWeb, :live_view

  def mount(params, session, socket) do
    {:ok, socket}
  end

  def handle_event("submit-username", %{"username" => username} = assigns, socket) do
    {:noreply,
     socket
     |> assign(:username, username)
     |> push_navigate(to: ~p"/chat?username=#{username}")}
  end

  def render(assigns) do
    ~H"""
    <.form id="name-getter" phx-submit="submit-username">
      <.input class="input" type="text" name="username" field={:username} value="" placeholder="Enter name"/>
      <button class="btn">Save</button>
    </.form>
    """
  end
end
