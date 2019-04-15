defmodule Data.Repo.Migrations.CreateInfections do
  use Ecto.Migration

  def change do
    create table(:infections) do
      add(:encounter_id, references(:encounters))
      add(:is_complete, :boolean, default: false, null: false)
      add(:is_active, :boolean, default: true, null: false)
    end
  end
end
