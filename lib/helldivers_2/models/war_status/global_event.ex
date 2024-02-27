defmodule Helldivers2.Models.WarStatus.GlobalEvent do
  alias Helldivers2.WarSeason
  alias Helldivers2.Models.WarInfo.Planet
  alias Helldivers2.Models.WarInfo.Faction

  @type t :: %__MODULE__{
    id: non_neg_integer(),
    id_32: non_neg_integer(),
    portrait_id_32: non_neg_integer(),
    title: String.t(),
    title_32: non_neg_integer(),
    message: String.t(),
    message_id_32: non_neg_integer(),
    race: Faction.t(),
    flag: non_neg_integer(),
    assignment_id_32: non_neg_integer(),
    effect_ids: list(non_neg_integer()),
    planets: list(Planet.t()),
  }

  defstruct [
    :id,
    :id_32,
    :portrait_id_32,
    :title,
    :title_32,
    :message,
    :message_id_32,
    :race,
    :flag,
    :assignment_id_32,
    :effect_ids,
    :planets,
  ]

  @doc """
  Attempts to parse as much information as possible from the given `map` into a struct.
  """
  @spec parse(String.t(), map()) :: t()
  def parse(war_id, map) when is_map(map) do
    %__MODULE__{
      id: Map.get(map, "eventId"),
      id_32: Map.get(map, "id32"),
      portrait_id_32: Map.get(map, "portraitId32"),
      title: Map.get(map, "title"),
      title_32: Map.get(map, "titleId32"),
      message: Map.get(map, "message"),
      message_id_32: Map.get(map, "messageId32"),
      race: Faction.parse(Map.get(map, "race")),
      assignment_id_32: Map.get(map, "assignmentId32"),
      effect_ids: Enum.map(Map.get(map, "effectIds"), fn (effect_id) -> effect_id end),
      planets: Enum.map(Map.get(map, "planetIndices"), &WarSeason.get_planet!(war_id, &1))
    }
  end
end