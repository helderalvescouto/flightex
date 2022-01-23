defmodule Flightex.Users.Agent do
  use Agent

  alias Flightex.Users.User

  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%User{} = user), do: Agent.update(__MODULE__, &update_state(&1, user))

  def get(id), do: Agent.get(__MODULE__, &get_user(&1, id))

  defp get_user(state, id) do
    state
    |> Map.get(id)
    |> handle_get()
  end

  defp handle_get(nil), do: {:error, "User not found"}

  defp handle_get(user), do: {:ok, user}

  def get_all, do: Agent.get(__MODULE__, & &1)

  defp update_state(state, %User{id: id} = user), do: Map.put(state, id, user)
end
