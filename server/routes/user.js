const express = require("express");
const auth = require("../middleware/auth");
const userRouter = express.Router();
const { Product } = require("../models/product");
const User = require("../models/user");
const Order = require("../models/order");
userRouter.post("/api/user/add-to-cart", auth, async (request, response) => {
  try {
    const { id } = request.body;
    const product = await Product.findById(id);
    let user = await User.findById(request.user);
    if (user.cart.length == 0) {
      user.cart.push({ product, quantity: 1 });
    } else {
      let isProductFound = false;
      for (let i = 0; i < user.cart.length; i++) {
        if (user.cart[i].product._id.equals(product._id)) {
          isProductFound = true;
        }
      }
      if (isProductFound) {
        let finalProduct = user.cart.find((singleProductObject) =>
          singleProductObject.product._id.equals(product._id)
        );
        finalProduct.quantity += 1;
      } else {
        user.cart.push({ product, quantity: 1 });
      }
    }
    user = await user.save();
    response.json(user);
  } catch (error) {
    response.status(500).json({ error: error.message });
  }
});

userRouter.delete(
  "/api/product/remove-from-cart/:id",
  auth,
  async (request, response) => {
    try {
      const { id } = request.params;
      const product = await Product.findById(id);
      let user = await User.findById(request.user);

      for (let i = 0; i < user.cart.length; i++) {
        if (user.cart[i].product._id.equals(product._id)) {
          if (user.cart[i].quantity == 1) {
            user.cart.splice(i, 1);
          } else {
            user.cart[i].quantity -= 1;
          }
        }
      }

      user = await user.save();
      response.json(user);
    } catch (error) {
      response.status(500).json({ error: error.message });
    }
  }
);

userRouter.post("/api/user/update-address", auth, async (request, response) => {
  try {
    const { address } = request.body;
    let user = await User.findById(request.user);
    user.address = address;
    user = await user.save();
    response.json(user);
  } catch (error) {
    response.status(500).json({ error: error.message });
  }
});

userRouter.post("/api/user/order-product", auth, async (request, response) => {
  try {
    const { cart, totalPrice, address } = request.body;
    let products = [];
    for (let i = 0; i < cart.length; i++) {
      let product = await Product.findById(cart[i].product._id);
      if (product.quantity >= cart[i].quantity) {
        product.quantity -= cart[i].quantity;
        products.push({ product, quantity: cart[i].quantity });
        await product.save();
      } else {
        return response
          .status(400)
          .json({ message: `${product.name} is out of stock` });
      }
    }
    let user = await User.findById(request.user);
    user.cart = [];
    user = await user.save();
    let order = new Order({
      products,
      totalPrice,
      address,
      userId: request.user,
      orderedAt: new Date().getTime(),
    });
    order = await order.save();
    response.json(order);
  } catch (error) {
    response.status(500).json({ error: error.message });
  }
});

module.exports = userRouter;
