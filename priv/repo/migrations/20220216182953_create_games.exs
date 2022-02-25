defmodule Pool.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :start, :utc_datetime
      add :spread, :decimal
      add :over_under, :decimal
      add :home_team_id, references(:teams, on_delete: :nothing)
      add :away_team_id, references(:teams, on_delete: :nothing)

      timestamps()
    end

    create index(:games, [:home_team_id])
    create index(:games, [:away_team_id])
  end
end
