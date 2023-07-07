const express = require("express");
const auth = require("../middleware/auth");
const userRouter = express.Router();
const { Product } = require("../models/product");
const User = require("../models/user");
userRouter.post("/api/user/add-to-cart", auth, async (request, response) => {
  try {
    const { id } = request.body;
    const product = await Product.findById(id);
    const user = await User.findById(request.user);
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
    response.status(500).json({ error: "Something went wrong" });
  }
});

module.exports = userRouter;
