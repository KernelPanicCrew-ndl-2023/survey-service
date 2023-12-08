defmodule SurveysWeb.AnswerController do
  use SurveysWeb, :controller

  require Logger
  alias Surveys.Questions
  alias Surveys.Answers
  alias Surveys.Answers.Answer
  alias Surveys.Users

  action_fallback SurveysWeb.FallbackController

  def index(conn, _params) do
    answers = Answers.list_answers()
    render(conn, :index, answers: answers)
  end

  def create(conn, %{"answer" => %{"question_id" => question } = answer_params }) do

    with {:ok, _} <- Questions.get_question(question), {:ok, %Answer{} = answer} <- Answers.create_answer(answer_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/answers/#{answer}")
      |> render(:show, answer: answer)
    end
  end

  def show(conn, %{"id" => id}) do
    answer = Answers.get_answer!(id)
    render(conn, :show, answer: answer)
  end

  def update(conn, %{"id" => id, "answer" => answer_params}) do
    answer = Answers.get_answer!(id)

    with {:ok, %Answer{} = answer} <- Answers.update_answer(answer, answer_params) do
      render(conn, :show, answer: answer)
    end
  end

  def delete(conn, %{"id" => id}) do
    answer = Answers.get_answer!(id)

    with {:ok, %Answer{}} <- Answers.delete_answer(answer) do
      send_resp(conn, :no_content, "")
    end
  end

  def choose(conn, %{"id" => id}) do


    if (email = Enum.at(get_req_header(conn, "authorization"), 0)) == [] do
      conn |> put_status(:unauthorized)
    else

      Logger.debug("Getting choice from #{inspect(get_req_header(conn, "authorization"))}")
      Logger.debug(email)
      with {:ok, a} <- Answers.get_answer(id),
           {:ok, _} <- Answers.update_answer(a, %{total_answers: a.total_answers + 1}),
           {:ok, _} <- Users.increment_kg_of_co2(email, a.carbon_value) do

          put_status(conn, 204)

          text conn, ""
      end
    end
  end
end
