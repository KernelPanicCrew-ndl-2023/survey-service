defmodule Surveys.AnswersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Surveys.Answers` context.
  """

  @doc """
  Generate a answer.
  """
  def answer_fixture(attrs \\ %{}) do
    {:ok, answer} =
      attrs
      |> Enum.into(%{
        carbon_value: "120.5",
        question_id: "7488a646-e31f-11e4-aace-600308960662",
        total_answers: 42,
        value: "some value"
      })
      |> Surveys.Answers.create_answer()

    answer
  end
end
