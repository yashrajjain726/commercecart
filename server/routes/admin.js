const express = require("express");
const appRouter = express.Router();
const admin = require("../middleware/admin");
const Product = require("../models/product");

appRouter.get("/admin/add/products", admin, async (request, response) => {
  try {
    const { name, description, price, quantity, category, images } =
      request.body;
    let product = new Product({
      name,
      description,
      price,
      quantity,
      category,
      images,
    });
    product = await product.save();
    response.json(product);
  } catch (error) {
    response.status(500).json({ error: "Something went wrong" });
  }
});
