defmodule Surveys.QuestionsTest do
  use Surveys.DataCase

  alias Surveys.Questions

  describe "questions" do
    alias Surveys.Questions.Question

    import Surveys.QuestionsFixtures

    @invalid_attrs %{id: nil, next: nil, text: nil, previous: nil}

    test "list_questions/0 returns all questions" do
      question = question_fixture()
      assert Questions.list_questions() == [question]
    end

    test "get_question!/1 returns the question with given id" do
      question = question_fixture()
      assert Questions.get_question!(question.id) == question
    end

    test "create_question/1 with valid data creates a question" do
      valid_attrs = %{id: "some id", next: "some next", text: "some text", previous: "some previous"}

      assert {:ok, %Question{} = question} = Questions.create_question(valid_attrs)
      assert question.id == "some id"
      assert question.next == "some next"
      assert question.text == "some text"
      assert question.previous == "some previous"
    end

    test "create_question/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Questions.create_question(@invalid_attrs)
    end

    test "update_question/2 with valid data updates the question" do
      question = question_fixture()
      update_attrs = %{id: "some updated id", next: "some updated next", text: "some updated text", previous: "some updated previous"}

      assert {:ok, %Question{} = question} = Questions.update_question(question, update_attrs)
      assert question.id == "some updated id"
      assert question.next == "some updated next"
      assert question.text == "some updated text"
      assert question.previous == "some updated previous"
    end

    test "update_question/2 with invalid data returns error changeset" do
      question = question_fixture()
      assert {:error, %Ecto.Changeset{}} = Questions.update_question(question, @invalid_attrs)
      assert question == Questions.get_question!(question.id)
    end

    test "delete_question/1 deletes the question" do
      question = question_fixture()
      assert {:ok, %Question{}} = Questions.delete_question(question)
      assert_raise Ecto.NoResultsError, fn -> Questions.get_question!(question.id) end
    end

    test "change_question/1 returns a question changeset" do
      question = question_fixture()
      assert %Ecto.Changeset{} = Questions.change_question(question)
    end
  end
end
