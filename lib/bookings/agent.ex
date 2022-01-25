defmodule Flightex.Bookings.Agent do
  use Agent

  alias Flightex.Bookings.Booking

  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%Booking{} = booking) do
    Agent.update(__MODULE__, &update_state(&1, booking))

    {:ok, booking}
  end

  def get(id), do: Agent.get(__MODULE__, &get_booking(&1, id))

  def get_all(), do: Agent.get(__MODULE__, & &1)

  def get_booking(state, id) do
    state
    |> Map.get(id)
    |> handle_get()
  end

  defp handle_get(nil), do: {:error, "Booking not found"}
  defp handle_get(booking), do: {:ok, booking}

  defp update_state(state, %Booking{id: id} = booking), do: Map.put(state, id, booking)
end
