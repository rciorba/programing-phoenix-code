defmodule Rumblr.Multimedia.Permalink do
  @behaviour Ecto.Type

  def type, do: :id

  @doc """
  Cast from external input to internal format.
  """
  def cast(binary) when is_binary(binary) do
    case Integer.parse(binary) do
      {int, _} when int> 0 -> {:ok, int}
      _ -> :error
    end
  end

  def cast(integer) when is_integer(integer) do
    {:ok, integer}
  end

  def cast(_) do
    :error
  end

  @doc """
  Transform to db representation.
  """
  def dump(integer) when is_integer(integer) do
    {:ok, integer}
  end

  @doc """
  Transform from db representation.
  """
  def load(integer) when is_integer(integer) do
    {:ok, integer}
  end

end
