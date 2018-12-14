defmodule TomWeb.HallControllerTest do
  use TomWeb.ConnCase

  alias Tom.Rand

  @create_attrs %{transactions: 42, users: 42}
  @update_attrs %{transactions: 43, users: 43}
  @invalid_attrs %{transactions: nil, users: nil}

  def fixture(:hall) do
    {:ok, hall} = Rand.create_hall(@create_attrs)
    hall
  end

  describe "index" do
    test "lists all halls", %{conn: conn} do
      conn = get(conn, Routes.hall_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Halls"
    end
  end

  describe "new hall" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.hall_path(conn, :new))
      assert html_response(conn, 200) =~ "New Hall"
    end
  end

  describe "create hall" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.hall_path(conn, :create), hall: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.hall_path(conn, :show, id)

      conn = get(conn, Routes.hall_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Hall"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.hall_path(conn, :create), hall: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Hall"
    end
  end

  describe "edit hall" do
    setup [:create_hall]

    test "renders form for editing chosen hall", %{conn: conn, hall: hall} do
      conn = get(conn, Routes.hall_path(conn, :edit, hall))
      assert html_response(conn, 200) =~ "Edit Hall"
    end
  end

  describe "update hall" do
    setup [:create_hall]

    test "redirects when data is valid", %{conn: conn, hall: hall} do
      conn = put(conn, Routes.hall_path(conn, :update, hall), hall: @update_attrs)
      assert redirected_to(conn) == Routes.hall_path(conn, :show, hall)

      conn = get(conn, Routes.hall_path(conn, :show, hall))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, hall: hall} do
      conn = put(conn, Routes.hall_path(conn, :update, hall), hall: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Hall"
    end
  end

  describe "delete hall" do
    setup [:create_hall]

    test "deletes chosen hall", %{conn: conn, hall: hall} do
      conn = delete(conn, Routes.hall_path(conn, :delete, hall))
      assert redirected_to(conn) == Routes.hall_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.hall_path(conn, :show, hall))
      end
    end
  end

  defp create_hall(_) do
    hall = fixture(:hall)
    {:ok, hall: hall}
  end
end
