defmodule Data.Encounter do
  use DataWeb, :model
  @moduledoc false

  @derive Jason.Encoder

  schema "encounters" do
    belongs_to(:patient, Data.Patient)
    field(:is_active, :boolean, default: true)
  end

  @doc """

  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:patient_id, :is_active])
    |> foreign_key_constraint(:patient_id)
  end
end
