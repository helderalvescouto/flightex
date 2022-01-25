defmodule Flightex.Bookings.CreateOrUpdateTest do
  use ExUnit.Case, async: false

  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking
  alias Flightex.Bookings.CreateOrUpdate

  describe "call/1" do
    setup do
      Flightex.start_agents()

      :ok
    end

    test "when all params are valid, returns a valid tuple" do
      user_params = %{name: "Vanessa", email: "vanessa@banana.com", cpf: "12345698700"}

      {:ok, user} = Flightex.create_or_update_user(user_params)

      params = %{
        user_id: user.id,
        complete_date: "2001-05-07 03:05:00",
        local_origin: "Brasilia",
        local_destination: "Bananeiras"
      }

      {:ok, booking} = CreateOrUpdate.call(params)

      {:ok, response} = BookingAgent.get(booking.id)

      expected_response = %Booking{
        id: response.id,
        complete_date: ~N[2001-05-07 03:05:00],
        local_destination: "Bananeiras",
        local_origin: "Brasilia",
        user_id: user.id
      }

      assert response == expected_response
    end
  end
end
