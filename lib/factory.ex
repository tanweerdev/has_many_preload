defmodule Data.Factory do
  @moduledoc false

  use ExMachina.Ecto, repo: Data.Repo

  def patient_factory do
    %Data.Patient{
      first_name: "John",
      last_name: "Doe",
      date_of_birth: DateTime.utc_now(),
      is_active: true
    }
  end

  def encounter_factory do
    %Data.Encounter{
      is_active: true
    }
  end

  def infection_factory do
    %Data.Infection{
      is_active: true,
      is_complete: true
    }
  end

  def infection_revision_factory do
    %Data.InfectionRevision{
      is_active: true,
      is_complete: true
    }
  end
end
