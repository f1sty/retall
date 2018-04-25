require Logger
defmodule Github do

  def dowload_all(username) do
    username
    |> repos()
    |> Enum.map(&(Task.start(__MODULE__, :download, [&1])))
  end

  defp download(url) do
    Logger.info "Downloading #{url} repo."
    System.cmd "git", ["clone", url]
  end

  defp repos(username) do
    username
    |> repos_full()
    |> Enum.map(fn repo_data -> repo_data["clone_url"] end)
  end

  defp repos_full(username) do
    %{body: body} = Enum.join(["/orgs/", username, "/repos"]) |> Github.Api.get!
    Jason.decode!(body)
  end
end
