class PrefecturesController < ApplicationController
  # 連動プルダウン
  def areas
    @areas = Area.where(prefecture_id: params[:prefecture_id])
    render 'areas'
  end
end
