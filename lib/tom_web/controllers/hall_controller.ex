defmodule TomWeb.HallController do
  use TomWeb, :controller

  alias Tom.Rand
  alias Tom.Rand.Hall

  def index(conn, _params) do
    halls = Rand.list_halls()
    render(conn, "index.html", halls: halls)
  end

  def new(conn, _params) do
    changeset = Rand.change_hall(%Hall{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"hall" => hall_params}) do
  
    {:ok, blocks} = Rand.create_hall(hall_params)
    case {:ok, blocks} do
      {:ok, blocks} ->
        render(conn, "show.html", blocks: blocks)

      {:ok, hall} ->
        conn
        |> put_flash(:info, "Entered into database")
        |> redirect(to: Routes.hall_path(conn, :show, hall))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, block) do

    render(conn, "show.html", block: block)
  end

  def edit(conn, %{"id" => id}) do
    hall = Rand.get_hall!(id)
    changeset = Rand.change_hall(hall)
    render(conn, "edit.html", hall: hall, changeset: changeset)
  end

  def update(conn, %{"id" => id, "hall" => hall_params}) do
    hall = Rand.get_hall!(id)

    case Rand.update_hall(hall, hall_params) do
      {:ok, hall} ->
        conn
        |> put_flash(:info, "Hall updated successfully.")
        |> redirect(to: Routes.hall_path(conn, :show, hall))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", hall: hall, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    hall = Rand.get_hall!(id)
    {:ok, _hall} = Rand.delete_hall(hall)

    conn
    |> put_flash(:info, "Hall deleted successfully.")
    |> redirect(to: Routes.hall_path(conn, :index))
  end
end
