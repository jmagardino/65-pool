defmodule Pool.Repo.Migrations.CreateContests do
  use Ecto.Migration

  def change do
    create table(:contests) do
      add :name, :string

      timestamps()
    end
  end
end
