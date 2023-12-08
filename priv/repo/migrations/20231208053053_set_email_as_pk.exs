defmodule Surveys.Repo.Migrations.SetEmailAsPk do
  use Ecto.Migration

  def change do

    create(
      unique_index(
        :users,
        ~w(email)a,
        name: :index_for_unique_emails
      )
    )

  end
end
