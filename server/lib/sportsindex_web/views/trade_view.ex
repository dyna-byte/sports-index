defmodule SportsindexWeb.TradeView do
  use SportsindexWeb, :view
  alias SportsindexWeb.TradeView

  def render("index.json", %{trades: trades}) do
    %{data: render_many(trades, TradeView, "trade.json")}
  end

  def render("show.json", %{trade: trade}) do
    %{data: render_one(trade, TradeView, "trade.json")}
  end

  def render("trade.json", %{trade: trade}) do
    %{id: trade.id,
      price: trade.price,
      quantity: trade.quantity}
  end
end
