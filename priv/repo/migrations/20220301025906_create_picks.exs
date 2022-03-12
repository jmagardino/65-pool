defmodule Pool.Repo.Migrations.CreatePicks do
  use Ecto.Migration

  def change do
    create table(:picks) do
      add :point_total, :string
      add :game_id, references(:games, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)
      add :ats_winner_team_id, references(:teams, on_delete: :nothing)
      add :outright_winner_team_id, references(:teams, on_delete: :nothing)
      add :contest_id, references(:contests, on_delete: :nothing)

      timestamps()
    end

    create index(:picks, [:game_id])
    create index(:picks, [:user_id])
    create index(:picks, [:ats_winner_team_id])
    create index(:picks, [:outright_winner_team_id])
    create index(:picks, [:contest_id])
  end
end
