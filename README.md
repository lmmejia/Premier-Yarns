# Premier Yarns Online Store

CSEN 164 — Assignment #2 Leslie Mejia

## Project Description

I love to crochet in my free time, so I decided to recreate a small version of my favorite online shopping store! This store lets shoppers browse a yarn catalog, add items to cart, and check out while logged in. Users can sign up, log in, view their order history, and write reviews on products. Admins can manage the product catalog and moderate reviews.

## Main Features

### Store & Shopping
- Product catalog on the home page (`/`)
- Product index, show, and search pages
- Sidebar cart visible on every page
- Add to cart from the catalog and product detail page
- Checkout with payment type dropdown
- Cart clears after checkout; logged-in users keep their saved cart across sessions

### User Accounts
- Sign up, log in, and log out
- Session-based authentication

### Order History
- Orders belong to the logged in user
- Users can view only their own orders
- Admins can view all orders

### Product Reviews
- Logged in users can write reviews with 1-5 scale and comments
- Product pages show all reviews and average rating
- Users can edit/delete only their own reviews
- Admins can edit/delete any review

### Admin Features
- Only admins can create, edit, and delete products
- Product images can be uploaded as files

### Search
- Nav bar search by product name
- Redirects to `/products` and shows the closest matching products

## Models & Associations

User
  has_many :orders
  has_many :reviews
  has_one :cart

Product
  has_many :cartitems
  has_many :reviews

Cart
  belongs_to :user
  has_many :cartitems

Cartitem
  belongs_to :cart
  belongs_to :product
  belongs_to :order

Order
  belongs_to :user
  has_many :cartitems

Review
  belongs_to :user
  belongs_to :product

## CRUD Resources

### Products

* Create: Admin only
* Read: Everyone
* Update: Admin only
* Delete: Admin only

### Reviews

* Create: Logged-in users
* Read: Displayed on the product page
* Update: Review owner or admin
* Delete: Review owner or admin

### Orders

* Create: Generated during checkout by loggedin users
* Read: Users can view their own orders, admins can view all orders
* Update: Owner or admin
* Delete: Owner or admin 

## Validations

### User

* `userid` is required and must be unique
* `email` is required and must be unique
* `email` must follow a valid email format

### Product

* `name` is required and must be unique
* `description` is required
* `image` is required
* `price` is required and must be greater than or equal to $0.01
* `image` must be a GIF, JPG, or PNG file

### Review

* `rating` must be between 1 and 5
* `comment` is required

### Order

* `paytype` must be one of the allowed payment types

## How to Run the Application

### Setup
- bundle install
- bin/rails db:migrate
- bin/rails db:seed
- bin/rails server

Open [http://localhost:3000](http://localhost:3000) in the browser

Admin: 
User: admin
Password: password

Demo:
User: demo
Password: password

Demo2
User: demo2
Password: password


## Screenshots
### Home
<img width="1419" height="688" alt="Screenshot 2026-06-12 at 6 57 09 PM" src="https://github.com/user-attachments/assets/a92fe403-b300-455d-a5fc-fa42ada18c89" />

### Product
<img width="1292" height="706" alt="Screenshot 2026-06-12 at 6 58 06 PM" src="https://github.com/user-attachments/assets/186406a7-b6d5-4af2-99fc-a7a2babeb2eb" />

### Review
<img width="485" height="438" alt="Screenshot 2026-06-12 at 6 58 30 PM" src="https://github.com/user-attachments/assets/7066faf1-622b-4273-8e39-048a17b1cf07" />

### Orders
<img width="1422" height="487" alt="Screenshot 2026-06-12 at 6 58 54 PM" src="https://github.com/user-attachments/assets/3397e1ab-be42-4f73-882c-07f34ed7acbd" />

### LogIn
<img width="759" height="431" alt="Screenshot 2026-06-12 at 6 59 15 PM" src="https://github.com/user-attachments/assets/a8920d9b-8189-416e-8a2e-7d8f919caa06" />




## Known Limitations

- If you add products to the cart before logging in, those items are not saved when you log in (the app uses your existing account cart instead of merging the guest cart)
- If you add products while not logged in and then log in to check out, the cart may be empty and checkout will complete with no items
- Products/1 does not work, the products start at a large number like id: 40
