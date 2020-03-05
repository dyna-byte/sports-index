defmodule SportsindexWeb.WalletController do
  use SportsindexWeb, :controller

  alias Sportsindex.Wallets
  alias Sportsindex.Wallets.Wallet

  action_fallback SportsindexWeb.FallbackController

  def action(conn, _) do
    apply(__MODULE__, action_name(conn), [conn, conn.params, conn.assigns.current_user])
  end

  def index(conn, _params, user) do
    wallet = Wallets.get_user_wallet(user)
    render(conn, "show.json", wallet: wallet)
  end

  @doc """
  update the value of the wallet
  """
  def update(conn, %{"wallet" => wallet_params}, user) do
    wallet = Wallets.get_user_wallet(user)

    with {:ok, %Wallet{} = wallet} <- Wallets.update_wallet(wallet, wallet_params) do
      render(conn, "show.json", wallet: wallet)
    end
  end

  def add(conn, %{"amount" => amount}, user) when is_integer(amount) do
    with {:ok, %Wallet{} = wallet} <- Wallets.add_credit(user, amount) do
      render(conn, "show.json", wallet: wallet)
    end
  end

  def transactions(conn, _params, user) do
    # This can be a preload on wallet, however a seperate endpoint allows
    # addition of filteration/pagination to the transactions list
    transactions = Wallets.get_user_transactions(user)
    render(conn, "index.json", transactions: transactions)
  end
end
