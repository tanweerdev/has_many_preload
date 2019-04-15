defmodule Data.Repo.Migrations.CreateEncounters do
  use Ecto.Migration

  def change do
    create table(:encounters) do
      add(:patient_id, references(:patients), null: false)
      add(:is_active, :boolean, default: true, null: false)
    end
  end
end
