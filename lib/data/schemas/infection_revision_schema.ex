defmodule Data.InfectionRevision do
  @moduledoc false

  use DataWeb, :model

  @derive Jason.Encoder

  schema "infection_revisions" do
    field(:is_complete, :boolean, default: false)
    field(:is_active, :boolean, default: true)
    field(:revision_id, :integer)
    belongs_to(:encounter, Data.Encounter)
    has_one(:patient, through: [:encounter, :patient])
    belongs_to(:infection, Data.Infection)
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
      :encounter_id,
      :is_complete,
      :revision_id,
      :infection_id
    ])
    |> foreign_key_constraint(:encounter_id)
  end
end
