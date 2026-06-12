defmodule LiveTalkWeb.ChatLive do
  use LiveTalkWeb, :live_view
  alias LiveTalk.Comments
  alias LiveTalk.Comments.Comment

  defp get_empty_form(username),
    do: %Comment{} |> Comment.changeset(%{body: "", username: username}) |> to_form()

  def mount(params, _session, socket) do
    username = Map.get(params, "username", "empty")

    {:ok,
     socket
     |> assign(:username, username)
     |> assign(:comment, "")
     |> assign(
       :form,
       get_empty_form(username)
     )
     |> fetch_comments()}
  end

  defp fetch_comments(socket) do
    socket |> assign(:comments, Comments.list_comments())
  end

  def handle_event("validate", %{"comment" => params}, %{assigns: %{username: username}} = socket) do
    params_with_username = params |> Map.put_new("username", username)

    form =
      %Comment{}
      |> Comment.changeset(params_with_username)
      |> to_form(action: :validate)

    {:noreply, assign(socket, form: form)}
  end

  def handle_event(
        "save",
        %{"comment" => params},
        %{assigns: %{username: username}} = socket
      ) do
    params_with_username = params |> Map.put_new("username", username)

    case Comments.create_comment(params_with_username) do
      {:ok, _comment} ->
        {:noreply,
         socket
         |> fetch_comments()
         |> assign(
           :form,
           get_empty_form(username)
         )}

      {:error, %Ecto.Changeset{} = error_changeset} ->
        {:noreply, assign(socket, form: to_form(error_changeset))}
    end
  end

  def handle_event("delete-all", _params, socket) do
    Comments.delete_all_comments()
    {:noreply, socket |> fetch_comments()}
  end

  def render(assigns) do
    ~H"""
    <div class="h-full">
      <h1>You are now on the chat page, your username is: {@username}</h1>
      <div class="flex flex-col h-full">
        <div class="chat-display bg-slate-400 h-5/6 overflow-scroll"> This is where the chat display goes
          <%= for comment <- @comments do %>
              <li><span><%= comment.username %> - <%= comment.body %></span> </li>
              <% end %>
        </div>
        <div class="chat-input bg-blue-700 h-1/6"> This is where we are gonna let the user do the input
          <.form phx-submit="save" phx-change="validate" phx-auto-recover="ignore" for={@form}>
            <.input class="input" type="text" field={@form[:body]} placeholder="Type and press enter to send"/>

            <div class="flex gap-2">
              <button type="submit" class="btn">Send</button>
              <button type="button" class="btn btn-error" phx-click="delete-all">Delete All Messages</button>
            </div>
          </.form>
        </div>
      </div>
    </div>
    """
  end
end
