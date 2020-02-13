defmodule SportsindexWeb.OrderController do
  use SportsindexWeb, :controller

  alias Sportsindex.Trades
  alias Sportsindex.Trades.Order

  action_fallback SportsindexWeb.FallbackController

  def index(conn, _params) do
    orders = Trades.list_orders()
    render(conn, "index.json", orders: orders)
  end

  def create(conn, %{"order" => order_params}) do
    with {:ok, %Order{} = order} <- Trades.create_order(order_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.order_path(conn, :show, order))
      |> render("show.json", order: order)
    end
  end

  def show(conn, %{"id" => id}) do
    order = Trades.get_order!(id)
    render(conn, "show.json", order: order)
  end

  def update(conn, %{"id" => id, "order" => order_params}) do
    order = Trades.get_order!(id)

    with {:ok, %Order{} = order} <- Trades.update_order(order, order_params) do
      render(conn, "show.json", order: order)
    end
  end

  def delete(conn, %{"id" => id}) do
    order = Trades.get_order!(id)

    with {:ok, %Order{}} <- Trades.delete_order(order) do
      send_resp(conn, :no_content, "")
    end
  end
end
