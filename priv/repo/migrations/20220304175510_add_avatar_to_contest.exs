defmodule Pool.Repo.Migrations.AddAvatarToContest do
  use Ecto.Migration

  def change do
    alter table(:contests) do
      add :avatar, :string
    end
  end
end
