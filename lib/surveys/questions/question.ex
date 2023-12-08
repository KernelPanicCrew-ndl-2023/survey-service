defmodule Surveys.Questions.Question do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "questions" do
    # field :id, :string
    field :next, :string
    field :text, :string
    field :previous, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:id, :text, :previous, :next])
    |> validate_required([:id, :text, :previous, :next])
  end
end
