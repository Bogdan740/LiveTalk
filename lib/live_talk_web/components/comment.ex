defmodule LiveTalkWeb.Components.Comment do
  use Phoenix.Component
  alias LiveTalk.Comments.Comment

  attr(:comment, Comment, required: true)
  attr(:current_user_username, :string, required: true)

  def comment(assigns) do
    ~H"""
      <span>
        <%= format_time(@comment.inserted_at) %> |
        <span class={[if(@comment.username == @current_user_username, do: "text-yellow-300", else: "text-white")]}>
          <%= @comment.username %>
        </span>
        - <%= @comment.body %>
      </span>
    """
  end

  defp format_time(%DateTime{hour: hour, minute: minute, second: second}) do
    "#{hour}:#{minute}:#{second}"
  end
end
