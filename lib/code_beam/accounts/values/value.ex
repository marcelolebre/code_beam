defmodule CodeBeam.Value do
  @moduledoc """
  Macro to allow better API Response composition. With this module we're able to compose complex json messages faster and simpler.

  A Response base format can only be a List or a Map.
  """

  @doc """
  Initiate a Response base format as a List

  ## Examples
      iex> init_with_list()
      []
  """
  def init_with_list(), do: []

  @doc """
  Initiate a Response base format as a Map

  ## Examples
      iex> init_with_map()
      %{}
  """
  def init_with_map(), do: %{}

  @doc """
  Initiate a Response based on a pre-existing Struct.

  ## Examples
      iex> country = %Country{name: "Portugal", slug: "slug", code: "code", contracts: [], currency_id: nil, currency: nil, addresses: [], service_provider_details: [], payrolls: [], payslips: []}
      %Country{name: "Portugal", slug: "slug", code: "code", contracts: [], currency: nil, addresses: [], service_provider_details: [], payrolls: [], features: [], payslips: []}
      iex> init(country)
      %{contracts: [], id: nil, inserted_at: nil, name: "Portugal", slug: "slug", code: "code", updated_at: nil, currency: nil, currency_id: nil, addresses: [], service_provider_details: [], payrolls: [], features: [], payslips: []}

      iex> init(%{a: 1})
      %{a: 1}
      iex> init([1, 2, 3])
      [1, 2, 3]
  """
  def init(%{__struct__: _} = value) do
    Map.from_struct(value)
    |> Map.drop([:__meta__, :__struct__])
  end

  # Initiate a Response based on a pre-existing Map or List.
  def init(value) do
    value
  end

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

      iex> response = init(%{a: 1, b: 2})
      %{a: 1, b: 2}
      iex> add(response, %{c: 3})
      %{a: 1, b: 2, c: 3}
      iex> add(response, c: 3)
      %{a: 1, b: 2, c: 3}
  """
  def add(response, entry) when is_list(response), do: [entry | response]

  # Add an item to a Response Map. Accepts a keyword list with only one entry.
  def add(response, [{key, value}]) do
    Map.put(response, key, value)
  end

  # Add an item to a Response Map. Accepts a Map or a simple keyword list.
  def add(response, entry) when is_map(response) do
    Enum.reduce(entry, response, fn {key, value}, acc ->
      Map.put(acc, key, value)
    end)
  end
end
