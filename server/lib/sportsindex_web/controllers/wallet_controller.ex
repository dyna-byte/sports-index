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
    render(conn, "index.json", wallets: [wallet])
  end

  def create(conn , %{"wallet" => wallet_params}, user) do
    with {:ok, %Wallet{} = wallet} <- Wallets.create_wallet(wallet_params, user) do
      conn
      |> put_status(:created)
      |> render("show.json", wallet: wallet)
    end
  end

  def update(conn, %{"id" => id, "wallet" => wallet_params}, _user) do
    wallet = Wallets.get_wallet!(id)

    with {:ok, %Wallet{} = wallet} <- Wallets.update_wallet(wallet, wallet_params) do
      render(conn, "show.json", wallet: wallet)
    end
  end

  def delete(conn, %{"id" => id}, user) do
    wallet = Wallets.get_user_wallet!(id, user)
    cond do
      wallet.user.id == user.id ->
        with {:ok, %Wallet{}} <- Wallets.delete_wallet(wallet) do
          send_resp(conn, :no_content, "{}")
        end
      true ->
        send_resp(conn, :forbidden, "")
    end

  end
end
