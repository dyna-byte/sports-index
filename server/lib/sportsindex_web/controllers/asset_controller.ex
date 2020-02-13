defmodule SportsindexWeb.AssetController do
  use SportsindexWeb, :controller

  alias Sportsindex.Assets
  alias Sportsindex.Assets.Asset

  action_fallback SportsindexWeb.FallbackController

  def index(conn, _params) do
    assets = Assets.list_assets()
    render(conn, "index.json", assets: assets)
  end

  def create(conn, %{"asset" => asset_params}) do
    with {:ok, %Asset{} = asset} <- Assets.create_asset(asset_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.asset_path(conn, :show, asset))
      |> render("show.json", asset: asset)
    end
  end

  def show(conn, %{"id" => id}) do
    asset = Assets.get_asset!(id)
    render(conn, "show.json", asset: asset)
  end

  def update(conn, %{"id" => id, "asset" => asset_params}) do
    asset = Assets.get_asset!(id)

    with {:ok, %Asset{} = asset} <- Assets.update_asset(asset, asset_params) do
      render(conn, "show.json", asset: asset)
    end
  end

  def delete(conn, %{"id" => id}) do
    asset = Assets.get_asset!(id)

    with {:ok, %Asset{}} <- Assets.delete_asset(asset) do
      send_resp(conn, :no_content, "")
    end
  end
end
