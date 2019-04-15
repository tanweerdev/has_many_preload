defmodule Data.Infection do
  @moduledoc false

  use DataWeb, :model
  @derive Jason.Encoder

  schema "infections" do
    field(:is_complete, :boolean, default: false)
    field(:is_active, :boolean, default: true)
    belongs_to(:encounter, Data.Encounter)
    has_one(:patient, through: [:encounter, :patient])
    has_many(:revisions, Data.InfectionRevision)
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    params = params |> Map.new(fn {k, v} -> {to_string(k), v} end)

    struct
    |> cast(params, [
      :encounter_id,
      :is_complete
    ])
    |> foreign_key_constraint(:encounter_id)
  end
end
