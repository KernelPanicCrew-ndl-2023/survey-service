defmodule Surveys.Questions.Question do
  alias Surveys.Answers.Answer
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "questions" do
    # field :id, :string
    field :next, :string
    field :text, :string
    field :previous, :string
    has_many :answer, Answer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:id, :text, :previous, :next])
    |> validate_required([:text])
  end
end
