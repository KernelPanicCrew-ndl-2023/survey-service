defmodule Surveys.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Surveys.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        score: 120.5
      })
      |> Surveys.Users.create_user()

    user
  end
end
