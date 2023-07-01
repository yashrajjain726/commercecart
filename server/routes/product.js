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

module.exports = productRouter;
