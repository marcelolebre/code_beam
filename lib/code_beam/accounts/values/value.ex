defmodule CodeBeam.Value do

  def init_with_list(), do: []

  def init_with_map(), do: %{}

  @doc """
  Initiate a Response based on a pre-existing Struct.

  ## Examples
      iex> init([1, 2, 3])
      [1, 2, 3]
  """
  def init(%{__struct__: _} = value) do
    Map.from_struct(value) |> Map.drop([:__meta__, :__struct__])
  end

  # Initiate a Response based on a pre-existing Map or List.
  def init(value), do: value

  @doc """
  Remove specified keys from Response.

  ## Examples
      iex> response = init(%{a: 1, b: 2})
      %{a: 1, b: 2}
      iex> except(response, [:a])
      %{b: 2}
  """
  def except(response, keys) when is_map(response), do: Map.drop(response, keys)

  @doc """
  Return only specified keys from Response.

  ## Examples
      iex> response = init(%{a: 1, b: 2})
      %{a: 1, b: 2}
      iex> only(response, [:a])
      %{a: 1}
  """
  def only(response, keys) when is_map(response), do: Map.take(response, keys)

  @doc """
  Add an item to a Response list.

  ## Examples
      iex> response = init([1, 2, 3])
      [1, 2, 3]
      iex> add(response, 4)
      [4, 1, 2, 3]

  """
  def add(response, entry) when is_list(response), do: [entry | response]

  # Add an item to a Response Map. Accepts a keyword list with only one entry.
  def add(response, [{key, value}]), do: Map.put(response, key, value)

  # Add an item to a Response Map. Accepts a Map or a simple keyword list.
  def add(response, entry) when is_map(response) do
    Enum.reduce(entry, response, fn {key, value}, acc ->
      Map.put(acc, key, value)
    end)
  end
end
