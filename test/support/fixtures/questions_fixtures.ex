defmodule Surveys.QuestionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Surveys.Questions` context.
  """

  @doc """
  Generate a question.
  """
  def question_fixture(attrs \\ %{}) do
    {:ok, question} =
      attrs
      |> Enum.into(%{
        id: "some id",
        next: "some next",
        previous: "some previous",
        text: "some text"
      })
      |> Surveys.Questions.create_question()

    question
  end
end
