defmodule Tom.TransactionTest do
  use Tom.DataCase

  alias Tom.Transaction

  describe "users" do
    alias Tom.Transaction.User

    @valid_attrs %{amount: 42, from: "some from", to: "some to"}
    @update_attrs %{amount: 43, from: "some updated from", to: "some updated to"}
    @invalid_attrs %{amount: nil, from: nil, to: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Transaction.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Transaction.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Transaction.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Transaction.create_user(@valid_attrs)
      assert user.amount == 42
      assert user.from == "some from"
      assert user.to == "some to"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transaction.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Transaction.update_user(user, @update_attrs)
      assert user.amount == 43
      assert user.from == "some updated from"
      assert user.to == "some updated to"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Transaction.update_user(user, @invalid_attrs)
      assert user == Transaction.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Transaction.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Transaction.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Transaction.change_user(user)
    end
  end
end
