defmodule ExUtils.StructUtils do

  @doc """
  convert item to something that can be converted to json via Poison. The Result is still
  a list/map/string/whatever. 

  Very usefull to convert an ecto-model and feed to poison.
  """
  def to_json(_item)

  def to_json(%NaiveDateTime{} = nt), do: Timex.to_datetime(nt)
  def to_json(%DateTime{} = nt), do: Timex.to_datetime(nt)
  def to_json({{_, _, _}, {_, _, _, _}} = t), do: Timex.to_datetime(t)

  def to_json(struct) when is_map(struct) do
    struct
    |> Map.delete(:__struct__)
    |> Map.delete(:__meta__)
    |> Enum.map(fn {k, v} -> {k, to_json(v)} end)
    |> Enum.into(%{})
  end

  def to_json(list) when is_list(list) do
    list
    |> Enum.map(fn x -> to_json(x) end)
  end

  def to_json(x), do: x
end
