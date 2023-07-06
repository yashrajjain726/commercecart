const express = require("express");
const productRouter = express.Router();
const auth = require("../middleware/auth");
const Product = require("../models/product");

productRouter.get("/api/products", auth, async (request, response) => {
  try {
    const products = await Product.find({ category: request.query.category });
    response.json(products);
  } catch (error) {
    response.status(500).json({ error: error.message });
  }
});

productRouter.get(
  "/api/products/search/:name",
  auth,
  async (request, response) => {
    try {
      const products = await Product.find({
        name: { $regex: request.params.name, $options: "i" },
      });
      response.json(products);
    } catch (error) {
      response.status(500).json({ error: error.message });
    }
  }
);

productRouter.post("/api/product/rating", auth, async (request, response) => {
  const { id, rating } = request.body;
  try {
    let product = await Product.findById(id);
    for (let i = 0; i < product.ratings.length; i++) {
      if (product.ratings[i].userId == request.user) {
        product.ratings.splice(i, 1);
        break;
      }
    }
    const ratingSchema = {
      userId: request.user,
      rating,
    };
    product.ratings.push(ratingSchema);
    product = await product.save();
    response.json(product);
  } catch (error) {
    response.status(500).json({ error: error.message });
  }
});

module.exports = productRouter;
