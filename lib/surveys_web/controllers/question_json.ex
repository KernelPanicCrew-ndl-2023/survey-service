defmodule SurveysWeb.QuestionJSON do
  alias Surveys.Questions.Question

  @doc """
  Renders a list of questions.
  """
  def index(%{questions: questions}) do
    %{data: for(question <- questions, do: data(question))}
  end

  @doc """
  Renders a single question.
  """
  def show(%{question: question}) do
    %{data: data(question)}
  end

  defp data(%Question{} = question) do
    %{
      id: question.id,
      id: question.id,
      text: question.text,
      previous: question.previous,
      next: question.next
    }
  end
end
