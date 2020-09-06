defmodule CodeBeam.Accounts.Finder.SuperHeroName do
  require Logger

  @marvel_api_endpoint "https://gateway.marvel.com:443/v1/public/characters"
  @public_key Application.get_env(:code_beam, :marvel_public_key)
  @private_key Application.get_env(:code_beam, :marvel_private_key)

  def find(name) do
    search_marvel(name)
  end

  defp search_marvel(name) do
    with timestamp <- create_timestamp(),
         hash <- create_hash(timestamp),
         search_results <- search_characters(name, hash, timestamp) do
      get_character_status(search_results)
    end
  end

  defp search_characters(name, hash, timestamp) do
    with {:ok, response} <- HTTPoison.get(get_marvel_url(name, hash, timestamp)),
         character <- Jason.decode!(response.body) do
      character
    end
  end

  defp get_character_status(%{"data" => %{"results" => results}}) do
    with first_character <- List.first(results),
         name <- first_character["name"],
         description <- first_character["description"],
         comics <- first_character["comics"]["available"],
         events <- first_character["events"]["available"],
         stories <- first_character["stories"]["available"] do
      %{name: name, description: description, comics: comics, events: events, stories: stories}
    end
  end

  def get_marvel_url(name, hash, ts) do
    @marvel_api_endpoint <> "?name=#{name}&apikey=#{@public_key}&hash=#{hash}&ts=#{ts}"
  end

  defp create_hash(timestamp) do
    :crypto.hash(:md5, "#{timestamp}" <> @private_key <> @public_key)
    |> Base.encode16(case: :lower)
  end

  defp create_timestamp() do
    DateTime.utc_now()
    |> DateTime.to_unix()
  end
end
