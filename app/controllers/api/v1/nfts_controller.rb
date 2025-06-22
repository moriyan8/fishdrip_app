class Api::V1::NftsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    # 認証ロジックを入れるならここ
    logger.info("NFTミント記録: #{params[:wallet]} に token_id: #{params[:token_id]}")
    render json: { status: 'ok' }
  end
end
