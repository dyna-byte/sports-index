defmodule SportsindexWeb.TradeController do
  use SportsindexWeb, :controller

  alias Sportsindex.Trades
  alias Sportsindex.Trades.Trade

  action_fallback SportsindexWeb.FallbackController

  def index(conn, _params) do
    trades = Trades.list_trades()
    render(conn, "index.json", trades: trades)
  end

  def show(conn, %{"id" => id}) do
    trade = Trades.get_trade!(id)
    render(conn, "show.json", trade: trade)
  end
end
