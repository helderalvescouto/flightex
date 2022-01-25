defmodule Flightex.Bookings.CreateOrUpdateTest do
  use ExUnit.Case, async: false

  import Flightex.Factory

  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking
  alias Flightex.Bookings.CreateOrUpdate

  describe "call/1" do
    setup do
      BookingAgent.start_link(%{})

      :ok
    end

    test "when all params are valid, returns a valid tuple" do
      user = build(:user)

      params = %{
        user_id: user.id,
        complete_date: ~N[2001-05-07 03:05:00],
        local_origin: "Brasilia",
        local_destination: "Bananeiras"
      }

      {:ok, book} = CreateOrUpdate.call(params)

      {:ok, response} = BookingAgent.get(book.id)

      expected_response =
        {:ok,
         %Booking{
           id: response.id,
           complete_date: ~N[2001-05-07 03:05:00],
           local_destination: "Bananeiras",
           local_origin: "Brasilia",
           user_id: user.id
         }}

      assert response == expected_response
    end
  end
end
