defmodule Surveys.Answers.Answer do
  alias Surveys.Questions.Question
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "answers" do
    field :value, :string
    field :carbon_value, :integer
    field :total_answers, :integer
    belongs_to :question, Question

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(answer, attrs) do
    answer
    |> cast(attrs, [:carbon_value, :total_answers, :value, :question_id])
    |> validate_required([:carbon_value, :value, :question_id])
  end
end
