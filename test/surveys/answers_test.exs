defmodule Surveys.AnswersTest do
  use Surveys.DataCase

  alias Surveys.Answers

  describe "answers" do
    alias Surveys.Answers.Answer

    import Surveys.AnswersFixtures

    @invalid_attrs %{value: nil, carbon_value: nil, total_answers: nil, question_id: nil}

    test "list_answers/0 returns all answers" do
      answer = answer_fixture()
      assert Answers.list_answers() == [answer]
    end

    test "get_answer!/1 returns the answer with given id" do
      answer = answer_fixture()
      assert Answers.get_answer!(answer.id) == answer
    end

    test "create_answer/1 with valid data creates a answer" do
      valid_attrs = %{value: "some value", carbon_value: "120.5", total_answers: 42, question_id: "7488a646-e31f-11e4-aace-600308960662"}

      assert {:ok, %Answer{} = answer} = Answers.create_answer(valid_attrs)
      assert answer.value == "some value"
      assert answer.carbon_value == Decimal.new("120.5")
      assert answer.total_answers == 42
      assert answer.question_id == "7488a646-e31f-11e4-aace-600308960662"
    end

    test "create_answer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Answers.create_answer(@invalid_attrs)
    end

    test "update_answer/2 with valid data updates the answer" do
      answer = answer_fixture()
      update_attrs = %{value: "some updated value", carbon_value: "456.7", total_answers: 43, question_id: "7488a646-e31f-11e4-aace-600308960668"}

      assert {:ok, %Answer{} = answer} = Answers.update_answer(answer, update_attrs)
      assert answer.value == "some updated value"
      assert answer.carbon_value == Decimal.new("456.7")
      assert answer.total_answers == 43
      assert answer.question_id == "7488a646-e31f-11e4-aace-600308960668"
    end

    test "update_answer/2 with invalid data returns error changeset" do
      answer = answer_fixture()
      assert {:error, %Ecto.Changeset{}} = Answers.update_answer(answer, @invalid_attrs)
      assert answer == Answers.get_answer!(answer.id)
    end

    test "delete_answer/1 deletes the answer" do
      answer = answer_fixture()
      assert {:ok, %Answer{}} = Answers.delete_answer(answer)
      assert_raise Ecto.NoResultsError, fn -> Answers.get_answer!(answer.id) end
    end

    test "change_answer/1 returns a answer changeset" do
      answer = answer_fixture()
      assert %Ecto.Changeset{} = Answers.change_answer(answer)
    end
  end
end
