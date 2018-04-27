defmodule Github do
require Logger

  def dowload_all(username) do
    tasks = username
    |> repos()
    |> Enum.map(&(Task.async(__MODULE__, :download, [&1])))

    tasks
    |> Enum.each(&Task.await/1)
  end

  def download(url) do
    Logger.info "Downloading #{url} repo."
    System.cmd "git", ["clone", url]
    Logger.info "Finished downloading #{url}."
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
