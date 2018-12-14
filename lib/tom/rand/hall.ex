defmodule Tom.Rand.Hall do
  use Ecto.Schema
  import Ecto.Changeset


  schema "halls" do
    field :transactions, :integer
    field :users, :integer

    timestamps()
  end

  @doc false
  def changeset(hall, attrs) do
   
    hall
    |> cast(attrs, [:users, :transactions])
    |> validate_required([:users, :transactions])
  end
end
