defmodule SurveysWeb.QuestionJSON do
  alias Surveys.Questions.Question
  alias SurveysWeb.AnswerJSON

  @doc """
  Renders a list of questions.
  """
  def index(%{questions: questions}) do
    %{data: for(question <- questions, do: data(question))}
  end

  @doc """
  Renders a single question.
  """
  def show(%{question: question, answers: answers}) do
    %{data: data(question, answers)}
  end

  defp data(%Question{} = question) do
    %{
      id: question.id,
      text: question.text,
      previous: question.previous,
      next: question.next
    }
  end

  defp data(%Question{} = question, answers) do
    %{
      id: question.id,
      text: question.text,
      previous: question.previous,
      next: question.next,
      answers: for(a <- answers, do: Map.delete(AnswerJSON.data(a), :question_id))
    }
  end
end
