class PurchasesController < ApplicationController

def index
   if user_signed_in?

   else
     @purchases = Purchase.all

     respond_to do |format|
       #format.html  # index.html.erb
       format.json { render json: @purchases }
     end
   end
  #format.html "hello"
end

def show
  if params[:user] then
    @purchases = Purchase.find_by_buyer_id params[:user]
  else
    @purchase = Purchase.find(params[:id])
  end
   respond_to do |format|
     format.html
     format.svg  { render :qrcode => request.url.gsub('.svg','.html'), :unit => 10 }
     format.json { render json: @purchase }
   end
end


# GET /products/new
# GET /products/new.json
  def new
    if params[:product_id].to_i.is_a? Integer
      puts "awesome!"
      @product = Product.find(params[:product_id])
    else
      # remove %20 and - and replace with space
      name = params[:product_id].split('-').map! { |word| word.capitalize }.join(' ')
      #.split('%20').map! { |word| word.capitalize! }.join(' ')
      @product = Product.find_by_name name
    end

    @purchase = Purchase.create!(:product_id => @product.id)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @purchase }
    end
  end

  def update
    @disable_nav = true
    @disable_sidebar = true
    @charity = Charity.find(params[:donation_id])
    @purchase = Purchase.find(params[:purchase_id])
    @product = Product.find(@purchase.product_id)
    @donation = Donation.where(:charity_id => @charity.id,:purchase_id => @purchase.id).first
    @donation ||= Donation.create(:charity_id => @charity.id,:purchase_id => @purchase.id)
    @donation.save
    @purchase.donation_id = @donation.id
    @purchase.save

    # session['callback_code'] = @code
    if @purchase.donation_id
      respond_to do |format|
        format.html
      end
    else
      render "404"
    end
  end

#POST /products/:id/purchases
  def create
  @purchase = Purchase.new(params[:purchase])
  @purchase.product_id = params[:product_id]
  # @purchase.buyer_id =

  @product = Product.find params[:product_id]
  @purchase.save

  # Set your secret key: remember to change this to your live secret key in production
  # See your keys here https://manage.stripe.com/account
  # Stripe.api_key = "sk_test_B5RUJ3ZgW7BnB5VKp1vNbE7e"

  # Get the credit card details submitted by the form
  token = params[:stripeToken]
  # Create the charge on Stripe's servers - this will charge the user's card
  begin
    charge = Stripe::Charge.create(
      :amount => (@product.price * 100).to_i , # amount in cents, again
      :currency => "usd",
      :card => token,
      :description => "payinguser@example.com"
    )
  rescue Stripe::CardError => e
    # The card has been declined
    Rails.logger.info "error: #{e.message}"
  end

  # @purchase.stripe_customer_token = charge.id

  if @purchase.save_with_payment
    redirect_to [@product, @purchase], :url => {:action => "index"}, :notice => "Thank you for purchasing!"
  else
    render :new
  end
end

end
