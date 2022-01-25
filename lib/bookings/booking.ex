defmodule Flightex.Bookings.Booking do
  alias Flightex.Users.Agent, as: UserAgent

  @keys [:id, :complete_date, :local_origin, :local_destination, :user_id]
  @enforce_keys @keys

  defstruct @keys

  def build(_complete_date, local_origin, local_destination, user_id) when local_origin != "" and local_destination != "" do
    complete_date = NaiveDateTime.local_now()

    user_id
    |> UserAgent.get()
    |> build_booking(complete_date, local_origin, local_destination)
  end

  def build(_user_id, _local_origin, _local_destination),
    do: {:error, "Invalid parameters"}

  defp build_booking({:ok, user}, complete_date, local_origin, local_destination) do
    id = UUID.uuid4()

    {:ok,
     %__MODULE__{
       id: id,
       complete_date: complete_date,
       local_origin: local_origin,
       local_destination: local_destination,
       user_id: user.id
     }}
  end

  defp build_booking({:error, _reason} = error, _complete_date, _local_origin, _local_destination),
    do: error
end
