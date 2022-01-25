defmodule Flightex.Bookings.BookingTest do
  use ExUnit.Case, async: false

  import Flightex.Factory

  alias Flightex.Bookings.Booking

  describe "build/4" do
    test "when all params are valid, returns a booking" do
      user = build(:user)

      {:ok, response} =
        Booking.build(
          ~N[2001-05-07 01:46:20],
          "Brasilia",
          "ilha das bananas",
          user.id
        )

      expected_response = %Booking{
        complete_date: response.complete_date,
        id: response.id,
        local_destination: "ilha das bananas",
        local_origin: "Brasilia",
        user_id: response.user_id
      }

      assert response == expected_response
    end
  end
end
