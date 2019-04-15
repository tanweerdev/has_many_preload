defmodule Data.Patient do
  @moduledoc false

  use DataWeb, :model

  @derive Jason.Encoder

  schema "patients" do
    field(:first_name, :string, default: "")
    field(:last_name, :string, default: "")
    field(:date_of_birth, :date)
    field(:is_active, :boolean, default: true)
    has_many(:encounters, Data.Encounter)
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
      :first_name,
      :last_name,
      :date_of_birth,
      :is_active
    ])
  end
end
