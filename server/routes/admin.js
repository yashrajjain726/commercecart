const express = require("express");
const { default: mongoose } = require("mongoose");
const adminRouter = express.Router();
const admin = require("../middleware/admin");
const { Product } = require("../models/product");
const Order = require("../models/order");

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
    response.status(500).json({ error: error.message });
  }
});
adminRouter.get("/admin/products", admin, async (request, response) => {
  try {
    const products = await Product.find();
    response.json(products);
  } catch (error) {
    response.status(500).json({ error: error.message });
  }
});
adminRouter.post("/admin/delete/product", admin, async (request, response) => {
  try {
    const { id } = request.body;
    let product = await Product.findByIdAndDelete(id);
    response.json(product);
  } catch (error) {
    response.status(500).json({ error: error.message });
  }
});

adminRouter.get("/admin/orders-received", admin, async (request, response) => {
  try {
    let orders = await Order.find({});
    response.json(orders);
  } catch (error) {
    response.status(500).json({ error: error.message });
  }
});

adminRouter.post(
  "/admin/order/change-status",
  admin,
  async (request, response) => {
    try {
      const { status, id } = request.body;
      let order = await Order.findById(id);
      order.status += 1;
      order = await order.save();
      response.json(order);
    } catch (error) {
      response.status(500).json({ error: error.message });
    }
  }
);
module.exports = adminRouter;
