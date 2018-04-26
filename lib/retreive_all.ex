defmodule RetreiveAll do
  @moduledoc """
  Documentation for RetreiveAll.
  """

  @doc """
  Usage: retreive_all <github_username> <base_dest_dir>
  """
  def main(args) do
    with dest_dir <- List.last(args) do
      File.mkdir dest_dir
      File.cd dest_dir
    end

    args |> List.first |> Github.dowload_all
  end
end
