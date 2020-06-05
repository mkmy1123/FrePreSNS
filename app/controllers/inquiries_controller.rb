class InquiriesController < ApplicationController
  before_action :new_inquiry, except: [:create]

  def report
  end

  def contact
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.save
      InquiryMailer.send_mail(@inquiry).deliver_now
      flash[:notice] = '送信しました！運営が確認次第すぐに対応させて頂きます！'
      redirect_to root_path
    else
      redirect_back(fallback_location: root_path)
      flash[:alert] = "Error発生！お手数ですがもう一度ご入力ください。"
    end
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:email, :content, :problemUrl)
  end

  def new_inquiry
    @inquiry = Inquiry.new
  end
end
