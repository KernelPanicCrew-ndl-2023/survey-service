defmodule SurveysWeb.QuestionController do
  use SurveysWeb, :controller

  alias Surveys.Questions
  alias Surveys.Questions.Question

  action_fallback SurveysWeb.FallbackController

  def index(conn, _params) do
    questions = Questions.list_questions()
    render(conn, :index, questions: questions)
  end

  def create(conn, %{"question" => question_params}) do
    with {:ok, %Question{} = question} <- Questions.create_question(question_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/questions/#{question}")
      |> render(:show, question: question)
    end
  end

  def show(conn, %{"id" => id}) do
    question = Questions.get_question!(id)
    render(conn, :show, question: question)
  end

  def update(conn, %{"id" => id, "question" => question_params}) do
    question = Questions.get_question!(id)

    with {:ok, %Question{} = question} <- Questions.update_question(question, question_params) do
      render(conn, :show, question: question)
    end
  end

  def delete(conn, %{"id" => id}) do
    question = Questions.get_question!(id)

    with {:ok, %Question{}} <- Questions.delete_question(question) do
      send_resp(conn, :no_content, "")
    end
  end
end