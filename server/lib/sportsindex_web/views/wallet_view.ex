defmodule SportsindexWeb.WalletView do
  use SportsindexWeb, :view
  alias SportsindexWeb.WalletView

  def render("index.json", %{wallets: wallets}) do
    %{data: render_many(wallets, WalletView, "wallet.json")}
  end

  def render("show.json", %{wallet: wallet}) do
    %{data: render_one(wallet, WalletView, "wallet.json")}
  end

  def render("wallet.json", %{wallet: wallet}) do
    %{id: wallet.id,
      currency: wallet.currency,
      value: wallet.value}
  end
end
