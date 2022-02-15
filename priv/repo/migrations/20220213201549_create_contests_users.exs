defmodule Pool.Repo.Migrations.CreateContestsUsers do
  use Ecto.Migration

  def change do
    create table(:contests_users) do
      add :user_id, references(:users)
      add :contest_id, references(:contests)
    end

    create unique_index(:contests_users, [:user_id, :contest_id])
  end
end
