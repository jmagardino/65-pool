defmodule Pool.Repo.Migrations.AddCreatedByToContests do
  use Ecto.Migration

  def change do
    alter table(:contests) do
      add :owner_account_id, references(:users)
    end
  end
end
