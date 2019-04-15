defmodule Data.HasManyTest do
  use DataWeb.DataCase

  import Ecto.Query

  setup do
    patient = insert(:patient)
    encounter = insert(:encounter, patient: patient)
    infection = insert(:infection, patient: patient)
    infection_revision = insert(:infection_revision, infection: infection)
    infection_revision = insert(:infection_revision, infection: infection)

    {:ok,
     conn: guardian_login(user, instance), instance: instance, user: user, facility: facility}
  end

  test "working fine" do
    patient_query = from p0 in Data.Patient, limit: ^200, offset: ^0, select: map(p0, [:id])

    encounter_query =
      from e0 in Data.Encounter,
        left_join: p1 in assoc(e0, :patient),
        limit: ^200,
        offset: ^0,
        select: map(e0, [:id, :patient_id]),
        preload: [patient: ^patient_query]

    revisions_query =
      from i0 in Data.InfectionRevision, limit: ^200, offset: ^0, select: map(i0, [:revision_id])

    query =
      from i0 in Data.Infection,
        left_join: e1 in assoc(i0, :encounter),
        left_join: r3 in assoc(i0, :revisions),
        order_by: [asc: i0.id],
        limit: ^10,
        offset: ^0,
        select: map(i0, [:id, :encounter_id, :facility_id]),
        preload: [encounter: ^encounter_query, revisions: ^revisions_query]
  end
end
