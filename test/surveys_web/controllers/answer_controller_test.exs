defmodule SurveysWeb.AnswerControllerTest do
  use SurveysWeb.ConnCase

  import Surveys.AnswersFixtures

  alias Surveys.Answers.Answer

  @create_attrs %{
    value: "some value",
    carbon_value: "120.5",
    total_answers: 42,
    question_id: "7488a646-e31f-11e4-aace-600308960662"
  }
  @update_attrs %{
    value: "some updated value",
    carbon_value: "456.7",
    total_answers: 43,
    question_id: "7488a646-e31f-11e4-aace-600308960668"
  }
  @invalid_attrs %{value: nil, carbon_value: nil, total_answers: nil, question_id: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all answers", %{conn: conn} do
      conn = get(conn, ~p"/api/answers")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create answer" do
    test "renders answer when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/answers", answer: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/answers/#{id}")

      assert %{
               "id" => ^id,
               "carbon_value" => "120.5",
               "question_id" => "7488a646-e31f-11e4-aace-600308960662",
               "total_answers" => 42,
               "value" => "some value"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/answers", answer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update answer" do
    setup [:create_answer]

    test "renders answer when data is valid", %{conn: conn, answer: %Answer{id: id} = answer} do
      conn = put(conn, ~p"/api/answers/#{answer}", answer: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/answers/#{id}")

      assert %{
               "id" => ^id,
               "carbon_value" => "456.7",
               "question_id" => "7488a646-e31f-11e4-aace-600308960668",
               "total_answers" => 43,
               "value" => "some updated value"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, answer: answer} do
      conn = put(conn, ~p"/api/answers/#{answer}", answer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete answer" do
    setup [:create_answer]

    test "deletes chosen answer", %{conn: conn, answer: answer} do
      conn = delete(conn, ~p"/api/answers/#{answer}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/answers/#{answer}")
      end
    end
  end

  defp create_answer(_) do
    answer = answer_fixture()
    %{answer: answer}
  end
end
