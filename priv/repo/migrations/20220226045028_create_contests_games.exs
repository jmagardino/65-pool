defmodule Pool.Repo.Migrations.CreateContestsGames do
  use Ecto.Migration

  def change do
    create table(:contests_games) do
      add :contest_id, references(:contests)
      add :game_id, references(:games)
    end

    create unique_index(:contests_games, [:contest_id, :game_id])
  end
end
