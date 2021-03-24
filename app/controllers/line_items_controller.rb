class LineItemsController < ApplicationController
  def create
    # Find associated product
    # If new product, create line_item and attach product and cart ids to it
    # If product already exists in the cart then find the line_item with this product and increment its quantity by 1
    product = Product.find(params[:product_id])
    cart = @cart
  
    if cart.products.include?(product)
      @line_item = cart.line_items.find_by(product_id: product.id)
      @line_item.quantity += 1
    else
      @line_item = LineItem.new
      @line_item.cart = cart
      @line_item.product = product
    end
    @line_item.save
    redirect_to cart_path(cart)
  end

  def update
    # used to modify a line item, which also updates the cart for the reoccuring order
    # find line item
    # update one or more of the params
    # save and redirect to the cart path
    @line_item = LineItem.find(params[:id])
    @line_item.update(line_item_params)
    @line_item.save
    redirect_to cart_path(cart)
  end
  
  private
    def line_item_params
      params.require(:line_item).permit(:quantity, :product_id, :cart_id)
    end
end
