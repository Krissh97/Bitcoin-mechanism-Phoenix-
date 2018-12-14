defmodule Tom.RandTest do
  use Tom.DataCase

  alias Tom.Rand

  describe "halls" do
    alias Tom.Rand.Hall

    @valid_attrs %{transactions: 42, users: 42}
    @update_attrs %{transactions: 43, users: 43}
    @invalid_attrs %{transactions: nil, users: nil}

    def hall_fixture(attrs \\ %{}) do
      {:ok, hall} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Rand.create_hall()

      hall
    end

    test "list_halls/0 returns all halls" do
      hall = hall_fixture()
      assert Rand.list_halls() == [hall]
    end

    test "get_hall!/1 returns the hall with given id" do
      hall = hall_fixture()
      assert Rand.get_hall!(hall.id) == hall
    end

    test "create_hall/1 with valid data creates a hall" do
      assert {:ok, %Hall{} = hall} = Rand.create_hall(@valid_attrs)
      assert hall.transactions == 42
      assert hall.users == 42
    end

    test "create_hall/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rand.create_hall(@invalid_attrs)
    end

    test "update_hall/2 with valid data updates the hall" do
      hall = hall_fixture()
      assert {:ok, %Hall{} = hall} = Rand.update_hall(hall, @update_attrs)
      assert hall.transactions == 43
      assert hall.users == 43
    end

    test "update_hall/2 with invalid data returns error changeset" do
      hall = hall_fixture()
      assert {:error, %Ecto.Changeset{}} = Rand.update_hall(hall, @invalid_attrs)
      assert hall == Rand.get_hall!(hall.id)
    end

    test "delete_hall/1 deletes the hall" do
      hall = hall_fixture()
      assert {:ok, %Hall{}} = Rand.delete_hall(hall)
      assert_raise Ecto.NoResultsError, fn -> Rand.get_hall!(hall.id) end
    end

    test "change_hall/1 returns a hall changeset" do
      hall = hall_fixture()
      assert %Ecto.Changeset{} = Rand.change_hall(hall)
    end
  end
end
