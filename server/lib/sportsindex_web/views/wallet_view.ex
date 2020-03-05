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
      value: wallet.value}
  end

  def render("index.json", %{transactions: transactions}) do
    %{data: render_many(transactions, WalletView, "transaction.json", as: :transaction)}
  end

  def render("show.json", %{transaction: transaction}) do
    %{data: render_one(transaction, WalletView, "transaction.json", as: :transaction)}
  end

  def render("transaction.json", %{transaction: transaction}) do
    %{id: transaction.id,
      amount: transaction.amount,
      source: transaction.source,
      inserted_at: transaction.inserted_at
    }
  end
end
