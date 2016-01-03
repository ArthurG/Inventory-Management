class PurchaseCategoriesController < ApplicationController
  before_action :set_purchase_category, only: [:show, :edit, :update, :destroy]

  # GET /purchase_categories
  # GET /purchase_categories.json
  def index
    @purchase_categories = PurchaseCategory.all
  end

  # GET /purchase_categories/1
  # GET /purchase_categories/1.json
  def show
  end

  # GET /purchase_categories/new
  def new
    @purchase_category = PurchaseCategory.new
  end

  # GET /purchase_categories/1/edit
  def edit
  end

  # POST /purchase_categories
  # POST /purchase_categories.json
  def create
    @purchase_category = PurchaseCategory.new(purchase_category_params)

    respond_to do |format|
      if @purchase_category.save
        format.html { redirect_to @purchase_category, notice: 'Purchase category was successfully created.' }
        format.json { render :show, status: :created, location: @purchase_category }
      else
        format.html { render :new }
        format.json { render json: @purchase_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /purchase_categories/1
  # PATCH/PUT /purchase_categories/1.json
  def update
    respond_to do |format|
      if @purchase_category.update(purchase_category_params)
        format.html { redirect_to @purchase_category, notice: 'Purchase category was successfully updated.' }
        format.json { render :show, status: :ok, location: @purchase_category }
      else
        format.html { render :edit }
        format.json { render json: @purchase_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchase_categories/1
  # DELETE /purchase_categories/1.json
  def destroy
    @purchase_category.destroy
    respond_to do |format|
      format.html { redirect_to purchase_categories_url, notice: 'Purchase category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase_category
      @purchase_category = PurchaseCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_category_params
      params.require(:purchase_category).permit(:name)
    end
end
