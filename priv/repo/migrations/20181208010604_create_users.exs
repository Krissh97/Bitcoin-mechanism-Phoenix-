defmodule Tom.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :from, :string
      add :to, :string
      add :amount, :integer

      timestamps()
    end

  end
end
