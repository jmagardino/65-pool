defmodule Pool.Repo.Migrations.AddFieldsToTeams do
  use Ecto.Migration

  def change do
    alter table(:teams) do
      add :name, :string
      add :city, :string
      add :key, :string
      add :conference, :string
      add :division, :string
      add :stadium_details, :string
      add :colors, {:map, :string}
    end
  end
end
