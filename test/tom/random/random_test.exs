defmodule Tom.RandomTest do
  use Tom.DataCase

  alias Tom.Random

  describe "things" do
    alias Tom.Random.Thing

    @valid_attrs %{Number: "some Number", of: "some of", transactions: 42, users: 42}
    @update_attrs %{Number: "some updated Number", of: "some updated of", transactions: 43, users: 43}
    @invalid_attrs %{Number: nil, of: nil, transactions: nil, users: nil}

    def thing_fixture(attrs \\ %{}) do
      {:ok, thing} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Random.create_thing()

      thing
    end

    test "list_things/0 returns all things" do
      thing = thing_fixture()
      assert Random.list_things() == [thing]
    end

    test "get_thing!/1 returns the thing with given id" do
      thing = thing_fixture()
      assert Random.get_thing!(thing.id) == thing
    end

    test "create_thing/1 with valid data creates a thing" do
      assert {:ok, %Thing{} = thing} = Random.create_thing(@valid_attrs)
      assert thing.Number == "some Number"
      assert thing.of == "some of"
      assert thing.transactions == 42
      assert thing.users == 42
    end

    test "create_thing/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Random.create_thing(@invalid_attrs)
    end

    test "update_thing/2 with valid data updates the thing" do
      thing = thing_fixture()
      assert {:ok, %Thing{} = thing} = Random.update_thing(thing, @update_attrs)
      assert thing.Number == "some updated Number"
      assert thing.of == "some updated of"
      assert thing.transactions == 43
      assert thing.users == 43
    end

    test "update_thing/2 with invalid data returns error changeset" do
      thing = thing_fixture()
      assert {:error, %Ecto.Changeset{}} = Random.update_thing(thing, @invalid_attrs)
      assert thing == Random.get_thing!(thing.id)
    end

    test "delete_thing/1 deletes the thing" do
      thing = thing_fixture()
      assert {:ok, %Thing{}} = Random.delete_thing(thing)
      assert_raise Ecto.NoResultsError, fn -> Random.get_thing!(thing.id) end
    end

    test "change_thing/1 returns a thing changeset" do
      thing = thing_fixture()
      assert %Ecto.Changeset{} = Random.change_thing(thing)
    end
  end

  describe "things" do
    alias Tom.Random.Thing

    @valid_attrs %{transactions: 42, users: 42}
    @update_attrs %{transactions: 43, users: 43}
    @invalid_attrs %{transactions: nil, users: nil}

    def thing_fixture(attrs \\ %{}) do
      {:ok, thing} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Random.create_thing()

      thing
    end

    test "list_things/0 returns all things" do
      thing = thing_fixture()
      assert Random.list_things() == [thing]
    end

    test "get_thing!/1 returns the thing with given id" do
      thing = thing_fixture()
      assert Random.get_thing!(thing.id) == thing
    end

    test "create_thing/1 with valid data creates a thing" do
      assert {:ok, %Thing{} = thing} = Random.create_thing(@valid_attrs)
      assert thing.transactions == 42
      assert thing.users == 42
    end

    test "create_thing/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Random.create_thing(@invalid_attrs)
    end

    test "update_thing/2 with valid data updates the thing" do
      thing = thing_fixture()
      assert {:ok, %Thing{} = thing} = Random.update_thing(thing, @update_attrs)
      assert thing.transactions == 43
      assert thing.users == 43
    end

    test "update_thing/2 with invalid data returns error changeset" do
      thing = thing_fixture()
      assert {:error, %Ecto.Changeset{}} = Random.update_thing(thing, @invalid_attrs)
      assert thing == Random.get_thing!(thing.id)
    end

    test "delete_thing/1 deletes the thing" do
      thing = thing_fixture()
      assert {:ok, %Thing{}} = Random.delete_thing(thing)
      assert_raise Ecto.NoResultsError, fn -> Random.get_thing!(thing.id) end
    end

    test "change_thing/1 returns a thing changeset" do
      thing = thing_fixture()
      assert %Ecto.Changeset{} = Random.change_thing(thing)
    end
  end
end
