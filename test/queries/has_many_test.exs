defmodule Data.HasManyTest do
  use Data.DataCase

  import Ecto.Query

  setup do
    patient = insert(:patient)
    encounter = insert(:encounter, patient: patient)
    infection = insert(:infection, encounter: encounter)
    _infection_2 = insert(:infection, encounter: encounter)
    _infection_3 = insert(:infection, encounter: encounter)

    _infection_revision =
      insert(:infection_revision, infection: infection, encounter: encounter, revision_id: 1)

    _infection_revision_2 =
      insert(:infection_revision, infection: infection, encounter: encounter, revision_id: 2)

    {:ok, infection: infection}
  end

  test "same resource returned multiple times when preload has_many relation", %{
    infection: infection_passed
  } do
    patient_query =
      from p0 in Data.Patient,
        limit: ^200,
        offset: ^0,
        select: map(p0, [:id, :first_name, :last_name])

    encounter_query =
      from e0 in Data.Encounter,
        left_join: p1 in assoc(e0, :patient),
        limit: ^200,
        offset: ^0,
        select: map(e0, [:id, :patient_id, :is_active]),
        preload: [patient: ^patient_query]

    revisions_query =
      from i0 in Data.InfectionRevision,
        limit: ^200,
        offset: ^0,
        select: map(i0, [:revision_id, :infection_id])

    query =
      from i0 in Data.Infection,
        left_join: e1 in assoc(i0, :encounter),
        left_join: r3 in assoc(i0, :revisions),
        order_by: [asc: i0.id],
        limit: ^10,
        offset: ^0,
        select: map(i0, [:id, :encounter_id, :is_active]),
        preload: [encounter: ^encounter_query, revisions: ^revisions_query]

    infections = Data.Repo.all(query)
    IO.inspect("infections with has_many revisions")
    IO.inspect(infections)

    inf_count =
      Enum.reduce(infections, 0, fn inf, count ->
        if inf.id == infection_passed.id do
          count + 1
        else
          count
        end
      end)

    assert inf_count == 2

    # Please note the infection passed was having two revisions and when I fetched data, it was returned two times
  end

  test "resources returned as expected when preload has_many relation doesnt have join", %{
    infection: infection_passed
  } do
    patient_query =
      from p0 in Data.Patient,
        limit: ^200,
        offset: ^0,
        select_merge: map(p0, [:id, :first_name, :last_name])

    encounter_query =
      from e0 in Data.Encounter,
        left_join: p1 in assoc(e0, :patient),
        limit: ^200,
        offset: ^0,
        select_merge: map(e0, [:id, :patient_id, :is_active]),
        preload: [patient: ^patient_query]

    revisions_query =
      from i0 in Data.InfectionRevision,
        limit: ^200,
        offset: ^0,
        select_merge: map(i0, [:revision_id, :infection_id])

    query =
      from i0 in Data.Infection,
        left_join: e1 in assoc(i0, :encounter),
        # left_join: r3 in assoc(i0, :revisions),
        order_by: [asc: i0.id],
        limit: ^10,
        offset: ^0,
        select_merge: map(i0, [:id, :encounter_id, :is_active]),
        preload: [encounter: ^encounter_query, revisions: ^revisions_query]

    IO.inspect("query")
    IO.inspect(query)
    infections = Data.Repo.all(query)
    IO.inspect("infections with has_many revisions")
    IO.inspect(infections)
    IO.inspect(Enum.count(infections))

    inf_count =
      Enum.reduce(infections, 0, fn inf, count ->
        if inf.id == infection_passed.id do
          count + 1
        else
          count
        end
      end)

    assert inf_count == 1

    # Infection passed was having two revisions and when I fetched data, it was returned one times
  end

  test "same resource returned ok when we do not preload has_many relation", %{
    infection: infection_passed
  } do
    patient_query =
      from p0 in Data.Patient,
        limit: ^200,
        offset: ^0,
        select: map(p0, [:id, :first_name, :last_name])

    encounter_query =
      from e0 in Data.Encounter,
        left_join: p1 in assoc(e0, :patient),
        limit: ^200,
        offset: ^0,
        select: map(e0, [:id, :patient_id, :is_active]),
        preload: [patient: ^patient_query]

    query =
      from i0 in Data.Infection,
        left_join: e1 in assoc(i0, :encounter),
        order_by: [asc: i0.id],
        limit: ^10,
        offset: ^0,
        select: map(i0, [:id, :encounter_id, :is_active]),
        preload: [encounter: ^encounter_query]

    infections = Data.Repo.all(query)
    IO.inspect("infections without revisions")
    IO.inspect(infections)

    inf_count =
      Enum.reduce(infections, 0, fn inf, count ->
        if inf.id == infection_passed.id do
          count + 1
        else
          count
        end
      end)

    assert inf_count == 1

    # Please note resource is returned only once totally fine
  end
end
