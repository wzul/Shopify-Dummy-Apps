class OptionsController < AuthenticatedController

  before_action :set_shop
  before_action :set_option

  skip_before_action :verify_authenticity_token, if: :jwt_shopify_domain

  def index
    @option = @options.limit(5).order('id desc')
  end

  def show
    @option = @options.find(params[:id])
  end

  def new
    @option = @options.new
  end

  def edit
    @option = @options.find(params[:id])
  end

  def create
    @option = @options.new(option_params)

    respond_to do |format|
      if @option.save
        format.html { redirect_to @option, notice: 'Option was successfully created.' }
        format.json { render :show, status: :created, location: @option }
      else
        format.html { render :new }
        format.json { render json: @option.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @option = @options.find(params[:id])
    respond_to do |format|
      if @option.update(option_params)
        format.html { redirect_to @option, notice: 'Option was successfully updated.' }
        format.json { render :show, status: :ok, location: @option }
      else
        format.html { render :edit }
        format.json { render json: @option.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @options.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to options_url, notice: 'Option was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_shop
      @shop = Shop.find_by(shopify_domain: @current_shopify_session.domain)
    end

    def set_option
      @options = @shop.options
    end

    def option_params
      params.require(:option).permit(:collection_slug)
    end
end
