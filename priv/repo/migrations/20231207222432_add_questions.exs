defmodule Surveys.Repo.Migrations.AddQuestions do
  use Ecto.Migration

  def change do
    create table(:questions, primary_key: false) do

      add :id, :uuid, primary_key: true
      add :text, :text, null: false
      add :previous, :string, null: true, size: 36
      add :next, :string, null: true, size: 36

      timestamps()
    end

    create table(:answers, primary_key: false) do

      add :id, :uuid, primary_key: true
      add :carbon_value, :float, null: false, default: 0
      add :total_answers, :int, default: 0
      add :value, :text, null: false
      add :question_id, references(:questions, on_delete: :nothing, type: :uuid)


      timestamps()
    end
  end
end
