const express = require("express");
const adminRouter = express.Router();
const admin = require("../middleware/admin");
const Product = require("../models/product");

adminRouter.post("/admin/add/product", admin, async (request, response) => {
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
adminRouter.get("/admin/get/products", admin, async (request, response) => {
  try {
    const products = await Product.find();
    response.json(products);
  } catch (error) {
    response.status(500).json({ error: error.message });
  }
});
module.exports = adminRouter;
