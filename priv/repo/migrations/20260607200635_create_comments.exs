defmodule LiveTalk.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :body, :string
      add :username, :string

      timestamps(type: :utc_datetime)
    end
  end
end
