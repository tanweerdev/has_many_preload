defmodule Data.Repo.Migrations.CreatePatients do
  use Ecto.Migration

  def change do
    create table(:patients) do
      add(:first_name, :string, null: false, default: "")
      add(:last_name, :string, null: false, default: "")
      add(:date_of_birth, :date)
      add(:is_active, :boolean, null: false, default: true)
    end
  end
end
