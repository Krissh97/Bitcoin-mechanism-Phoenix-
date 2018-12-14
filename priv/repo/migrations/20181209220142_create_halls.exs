defmodule Tom.Repo.Migrations.CreateHalls do
  use Ecto.Migration

  def change do
    create table(:halls) do
      add :users, :integer
      add :transactions, :integer

      timestamps()
    end

  end
end
