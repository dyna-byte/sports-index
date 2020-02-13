defmodule SportsindexWeb.AssetView do
  use SportsindexWeb, :view
  alias SportsindexWeb.AssetView

  def render("index.json", %{assets: assets}) do
    %{data: render_many(assets, AssetView, "asset.json")}
  end

  def render("show.json", %{asset: asset}) do
    %{data: render_one(asset, AssetView, "asset.json")}
  end

  def render("asset.json", %{asset: asset}) do
    %{id: asset.id,
      name: asset.name,
      issued: asset.issued}
  end
end
