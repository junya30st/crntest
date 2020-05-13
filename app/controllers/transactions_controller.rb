class TransactionsController < ApplicationController
  require "payjp"
  before_action :authenticate_user!
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]
  before_action :set_product, only: [:new, :create]
  before_action :set_card, only: [:create]


  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = Transaction.all
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    # @transaction = Transaction.new
    @product = Product.find(params[:product_id])
    # binding.pry
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  # POST /transactions.json
  def create
    # binding.pry
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
    # binding.pry
    Payjp::Charge.create(
      amount: @product.price, # 決済する値段
      card: params['payjp-token'],
      currency: 'jpy'
    )
    @transaction = Transaction.new(
      name: @product.name,
      price: @product.price,
      period: @product.limit,
      product_id: @product.id,
      user_id: current_user.id
    )
    if @transaction.save
      number = @product.number.to_i - 1
      @product.number = number
      @product.save
      redirect_to root_path
    else
      render action: "create"
    end

  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:product_id])
    end

    def set_card
      @card = Card.find_by(user_id: current_user.id)
    end

    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:name, :price, :period, :user_id, :product_id)
    end
end
