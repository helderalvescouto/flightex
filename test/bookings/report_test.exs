defmodule Flightex.Bookings.ReportTest do
  use ExUnit.Case, async: true

  import Flightex.Factory

  alias Flightex.Bookings.Report
  alias Flightex.Bookings.Agent, as: BookingAgent

  describe "generate/1" do
    test "when called, return the content" do
      BookingAgent.start_link(%{})

      {:ok, booking} =
        :booking
        |> build()
        |> BookingAgent.save()

      content = "#{booking.user_id},Brasilia,Bananeiras,2001-05-07 03:05:00\n"

      Report.create("report_test.csv")

      {:ok, file} = File.read("report_test.csv")

      assert file =~ content
    end
  end
end
