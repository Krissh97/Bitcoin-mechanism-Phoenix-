defmodule Tom.Rand do
  @moduledoc """
  The Rand context.
  """

  import Ecto.Query, warn: false
  alias Tom.Repo

  alias Tom.Rand.Hall

  @doc """
  Returns the list of halls.

  ## Examples

      iex> list_halls()
      [%Hall{}, ...]

  """
  def list_halls do
    Repo.all(Hall)
  end

  @doc """
  Gets a single hall.

  Raises `Ecto.NoResultsError` if the Hall does not exist.

  ## Examples

      iex> get_hall!(123)
      %Hall{}

      iex> get_hall!(456)
      ** (Ecto.NoResultsError)

  """
  def get_hall!(id), do: Repo.get!(Hall, id)

  @doc """
  Creates a hall.

  ## Examples

      iex> create_hall(%{field: value})
      {:ok, %Hall{}}

      iex> create_hall(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_hall(attrs \\ %{}) do
    chain=Bitcoin.parsi(attrs)
    #IO.inspect(Enum.at(chain,1))
    %Hall{}
    |> Hall.changeset(attrs)
    |> Repo.insert()
    {:ok, chain}
  end

  @doc """
  Updates a hall.

  ## Examples

      iex> update_hall(hall, %{field: new_value})
      {:ok, %Hall{}}

      iex> update_hall(hall, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_hall(%Hall{} = hall, attrs) do
    hall
    |> Hall.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Hall.

  ## Examples

      iex> delete_hall(hall)
      {:ok, %Hall{}}

      iex> delete_hall(hall)
      {:error, %Ecto.Changeset{}}

  """
  def delete_hall(%Hall{} = hall) do
    Repo.delete(hall)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking hall changes.

  ## Examples

      iex> change_hall(hall)
      %Ecto.Changeset{source: %Hall{}}

  """
  def change_hall(%Hall{} = hall) do
    Hall.changeset(hall, %{})
  end
end
