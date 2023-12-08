defmodule Surveys.Repo.Migrations.ChangeFloatToInt do
  use Ecto.Migration

  def change do
    alter table(:answers) do
      modify :carbon_value, :integer
    end
  end
end
