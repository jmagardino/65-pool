defmodule Pool.Repo.Migrations.AddWeatherToGame do
  use Ecto.Migration

  def change do
    alter table(:games) do
      add :forecast_temp, :integer
      add :forecast_desc, :string
      add :forecast_wind, :integer
    end
  end
end
