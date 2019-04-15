defmodule Data.Repo.Migrations.CreateInfectionRevisions do
  use Ecto.Migration

  def change do
    create table(:infection_revisions) do
      add(:encounter_id, references(:encounters))
      add(:is_complete, :boolean, default: false, null: false)
      add(:revision_id, :integer, nullxxw: false)
      add(:is_active, :boolean, default: true, null: false)
      add(:infection_id, references(:infections))
    end
  end
end
