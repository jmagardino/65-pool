defmodule Pool.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :name, :string
      add :logo, :string

      timestamps()
    end
  end
end
