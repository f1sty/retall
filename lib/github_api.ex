defmodule Github.Api do
  @moduledoc false

  @endpoint Application.fetch_env!(:retreive_all, :endpoint)

  use HTTPoison.Base

  def process_url(url) do
    @endpoint <> url
  end
end
