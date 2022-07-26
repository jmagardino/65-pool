defmodule Pool.Repo.Migrations.AddFieldsToTeams do
  use Ecto.Migration

  def change do
    alter table(:teams) do
      add :global_id, :integer
      add :city, :string
      add :key, :string
      add :conference, :string
      add :division, :string
      add :stadium_details, :map
      add :colors, {:map, :string}
    end
  end
end
