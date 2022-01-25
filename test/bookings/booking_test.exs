defmodule Flightex.Bookings.BookingTest do
  use ExUnit.Case, async: false

  alias Flightex.Bookings.Booking

  describe "build/4" do
    setup do
      Flightex.start_agents()

      :ok
    end

    test "when all params are valid, returns a booking" do
      user_params = %{name: "Vanessa", email: "vanessa@banana.com", cpf: "12345698700"}

      {:ok, user} = Flightex.create_or_update_user(user_params)

      {:ok, response} =
        Booking.build(
          "2001-05-07 01:46:20",
          "Brasilia",
          "ilha das bananas",
          user.id
        )

      expected_response = %Booking{
        complete_date: ~N[2001-05-07 01:46:20],
        id: response.id,
        local_destination: "ilha das bananas",
        local_origin: "Brasilia",
        user_id: response.user_id
      }

      assert response == expected_response
    end
  end
end
