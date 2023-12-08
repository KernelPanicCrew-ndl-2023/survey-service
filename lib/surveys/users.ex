defmodule Surveys.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias Surveys.Repo


  require Logger
  alias Surveys.Users.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  @doc """
  Yes this method was named in a hurry

  It takes in parameter a number of KG of co2 and tells you "you are in the top X% of the people that pollutes the less"
  I does this by searching at what place he would be on the "leaderboard"

  It returns a number between [0;100]
  """
  def get_score(kgCO2) do
    all = Repo.all(
      from t in Surveys.Users.User,
      order_by: [asc: t.score]
    ) |> Enum.map(fn u -> u.score end)

    case Enum.find_index(all, fn x -> x > kgCO2 end) do
      nil -> 100

      val ->
        Logger.debug("value #{inspect(all)}")
        (val+1) / length(all) * 100
    end

  end

  def increment_kg_of_co2(user, amount) do
    case Repo.get_by(User, email: user) do
      u when u != nil ->
        Repo.update(Ecto.Changeset.update_change(u, :score, &(&1 + amount)))
      _ -> Repo.insert(%User{ email: user, score: amount })
    end
  end
end
