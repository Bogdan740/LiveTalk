defmodule LiveTalk.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field(:body, :string)
    field(:username, :string)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body, :username])
    |> validate_required([:body, :username])
  end
end
