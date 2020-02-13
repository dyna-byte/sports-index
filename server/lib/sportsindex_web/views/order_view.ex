defmodule SportsindexWeb.OrderView do
  use SportsindexWeb, :view
  alias SportsindexWeb.OrderView

  def render("index.json", %{orders: orders}) do
    %{data: render_many(orders, OrderView, "order.json")}
  end

  def render("show.json", %{order: order}) do
    %{data: render_one(order, OrderView, "order.json")}
  end

  def render("order.json", %{order: order}) do
    %{id: order.id,
      quantity: order.quantity,
      price: order.price,
      side: order.side}
  end
end
