defmodule SportsindexWeb.AssetControllerTest do
  use SportsindexWeb.ConnCase

  alias Sportsindex.Assets
  alias Sportsindex.Assets.Asset

  @create_attrs %{
    issued: 42,
    name: "some name"
  }
  @update_attrs %{
    issued: 43,
    name: "some updated name"
  }
  @invalid_attrs %{issued: nil, name: nil}

  def fixture(:asset) do
    {:ok, asset} = Assets.create_asset(@create_attrs)
    asset
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all assets", %{conn: conn} do
      conn = get(conn, Routes.asset_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create asset" do
    test "renders asset when data is valid", %{conn: conn} do
      conn = post(conn, Routes.asset_path(conn, :create), asset: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.asset_path(conn, :show, id))

      assert %{
               "id" => id,
               "issued" => 42,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.asset_path(conn, :create), asset: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update asset" do
    setup [:create_asset]

    test "renders asset when data is valid", %{conn: conn, asset: %Asset{id: id} = asset} do
      conn = put(conn, Routes.asset_path(conn, :update, asset), asset: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.asset_path(conn, :show, id))

      assert %{
               "id" => id,
               "issued" => 43,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, asset: asset} do
      conn = put(conn, Routes.asset_path(conn, :update, asset), asset: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete asset" do
    setup [:create_asset]

    test "deletes chosen asset", %{conn: conn, asset: asset} do
      conn = delete(conn, Routes.asset_path(conn, :delete, asset))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.asset_path(conn, :show, asset))
      end
    end
  end

  defp create_asset(_) do
    asset = fixture(:asset)
    {:ok, asset: asset}
  end
end
