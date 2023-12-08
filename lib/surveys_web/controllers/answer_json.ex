defmodule SurveysWeb.AnswerJSON do
  alias Surveys.Answers.Answer

  @doc """
  Renders a list of answers.
  """
  def index(%{answers: answers}) do
    %{data: for(answer <- answers, do: data(answer))}
  end

  @doc """
  Renders a single answer.
  """
  def show(%{answer: answer}) do
    %{data: data(answer)}
  end

  def data(%Answer{} = answer) do
    %{
      id: answer.id,
      carbon_value: answer.carbon_value,
      total_answers: answer.total_answers,
      value: answer.value,
      question_id: answer.question_id
    }
  end
end
