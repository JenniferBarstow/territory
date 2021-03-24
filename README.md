# 
# README


### `Question 1`:

Model data for the following scenario:

1: It's possible for a user to create a reoccuring order

2: An order may consist of different types of products

3: A user can modify the contents of their order prior to being finalized

### Models and Relationships

#### Product:
Description -> Details about Product

Attributes -> :id(int), :type(int), :description(string)

Associations -> has_many :line_items, dependent: :destroy


#### LineItem:
Description -> Join Table for Product and Cart. Gives ability to add multiple quantities of a product to a Cart.

Attributes -> :id(int), :product_id(int), :order_id(int), :cart_id(int)

Associations ->

belongs_to :product
belongs_to :order
belongs_to :cart

#### Cart:
Description -> Stores LineItems before creating a new Order / checkout

Attributes -> :id(int), :user_id(int)

Associations ->

belongs_to :user
has_many :line_items, dependent: :destroy
has_many :products, through: :line_items

#### Order:
Description -> Last Step before checkout. Payment and shipping info and LineItems are transferred from Cart to Order

Attributes -> :id(int)

Associations -> has_many :line_items, dependent: :destroy


### `Question 2`:

Design a JSON API that allows a user to place a recurring order. Include any API
endpoint(s) you would use, example request and response, and any other
information you think would be helpful.

ENDPOINTS:

`POST /v1/orders`

`GET /v1/orders/:id`

`POST /v1/orders/:id`

`DELETE /v1/orders/:id`

`GET /v1/orders`



Example `POST` Response:

```
{
  "id": "1",
  "object": "order",
  "frquency": "weekly",
  "start_date": "date",
  "user_id": "1234",
  "line_items": {
    "data": [
      {
        "id": "1",
        "object": "line_item",
        quantity: "3",
        product_id: "4"
      },
       {
        "id": "2",
        "object": "line_item",
        quantity: "1",
        product_id: "5"
      }
    ]
  }
}
```


### `Question 3`:

A controller that handles a user request to modify products in their reoccuring order.
Code can be found in `line_items_controller.rb`
