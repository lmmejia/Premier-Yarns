# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Cartitem.delete_all
Cart.delete_all
Order.delete_all
Review.delete_all
Product.delete_all
User.delete_all

#users
demo = User.create!(
  userid: "demo",
  email: "demo@gmail.com",
  password: "password",
  password_confirmation: "password"
)

demo2 = User.create!(
  userid: "demo2",
  email: "demo2@gmail.com",
  password: "password",
  password_confirmation: "password"
)

admin = User.create!(
  userid: "admin",
  email: "admin@gmail.com",
  password: "password",
  password_confirmation: "password",
  admin: true
)

#products
parfait = Product.create!(name: "Parfait Chunky Yarn",
    description: 
    %{
        Our tried and true 100% polyester chenille yarn is a customer favorite! Machine washable, and incredibly soft, you’ll find this yarn irresistible. Knit or crochet blankets, scarves, and toys that everyone will want to snuggle. With our wide range of colors, you’re sure to find the perfect shade.

        Craft comfortably knowing that this yarn is safe for everyone! It has passed the highest standard, suitable for direct contact with the most sensitive skin, even babies and small children.
    },
    image: "pc.png",
    price: 5.49)

basix = Product.create!(name: "Basix Worsted",
    description:
    %{
        Get high-quality acrylic yarn that can conquer any project Basix® Worsted is available in a wide range of beautiful colors to suit any palette and preference. As an added bonus, it's machine washable and dryable for easy care. 

        Craft comfortably knowing that this yarn is safe for you! It has passed the highest standard, suitable for direct contact with the most sensitive skin, even babies and small children.
    },
    image: "basix.png",
    price: 4.99)

sprout = Product.create!(name: "Cotton Sprout Worsted",
    description:
    %{
        An expansion to the Cotton Sprout® family, we have added worsted weight solids and multis. The 100% cotton fibers are machine washable, and your projects will look great, wash after wash. These 6 multi-shades were developed to use on their own, or to match to the solids for beautiful projects.
    },
    image: "sprout.png",
    price: 4.39)
  
sweetroll = Product.create!(name: "Sweet Roll",
  description:
  %{
      Sweet Roll combines 3 colors in each ball. The yarn is designed to create wide stripes in a regular repeat, creating all the excitement of working with multiple colors, without the tedium of weaving in all those ends. Our range of color combinations includes something for everyone, from neutrals to brights to pastels. Craft comfortably knowing that this yarn is safe for everyone! It has passed the highest standard, suitable for direct contact with the most sensitive skin, even babies and small children.
  },
  image: "sweetroll.png",
  price: 6.49)

home = Product.create!(name: "Home Cotton Cone",
    description:
    %{
        Premier's blend of recycled cotton with polyester produces softer, more durable and more colorfast projects in knit or crochet. The bigger skein means fewer ends to weave in on larger projects.
    },
    image: "home.png",
    price: 12.99)
    
gradient = Product.create!(name: "Anti-Pilling Everyday® Worsted Gradient",
    description:
    %{
        Create soft color changes with ease with Anti-Pilling Everyday® Worsted Gradient. This worsted weight yarn is specially designed to gradually transition from dark to light tones as you stitch. Anti-Pilling Everyday® Worsted Gradient is made with Anti-Pilling Acrylic so your project will look Like New, Wash After Wash.™. Colors and gradient transitions may vary due to the dyeing process - Each Gradient skein is unique!
  },
    image: "gradient.png",
    price: 9.99) 

  


#demo stuff for carts
demo_cart = demo.create_cart!
demo_cart.cartitems.create!(product: parfait, quantity: 2)
demo_cart.cartitems.create!(product: basix, quantity: 1)

demo2_cart = demo2.create_cart!
demo2_cart.cartitems.create!(product: sprout, quantity: 1)
demo2_cart.cartitems.create!(product: parfait, quantity: 1)


#order demos
Order.create!(
  user: demo,
  name: "Demo",
  address: "500 El Camino Real, Santa Clara, CA",
  email: demo.email,
  paytype: "Credit Card"
)

Order.create!(
  user: demo2,
  name: "Demo",
  address: "500 El Camino Real, Santa Clara, CA",
  email: demo.email,
  paytype: "Credit Card"
)

Order.create!(
  user: admin,
  name: "Admin",
  address: "500 El Camino Real, Santa Clara, CA",
  email: admin.email,
  paytype: "Klarna"
)


#review demos
Review.create!(
  user: demo,
  product: parfait,
  rating: 5,
  comment: "Super soft and easy to work with"
)

Review.create!(
  user: admin,
  product: parfait,
  rating: 4,
  comment: "Beautiful color, but a little thin"
)

Review.create!(
  user: demo,
  product: basix,
  rating: 5,
  comment: "My go-to yarn for everyday projects."
)

Review.create!(
  user: admin,
  product: sprout,
  rating: 3,
  comment: "Nice cotton feel, but limited color options"
)

Review.create!(
  user: demo2,
  product: gradient,
  rating: 4,
  comment: "Beautiful gradient, but a little expensive"
)

Review.create!(
  user: demo2,
  product: home,
  rating: 5,
  comment: "I love the convenience of the larger skein!"
)