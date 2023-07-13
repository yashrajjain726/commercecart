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

adminRouter.get(
  "/admin/analytics/earning",
  admin,
  async (request, response) => {
    try {
      const orders = await Order.find({});
      let totalEarning = 0;
      for (let i = 0; i < orders.length; i++) {
        let singleOrder = orders[i];
        for (let j = 0; j < singleOrder.products.length; j++) {
          let singleProductObject = singleOrder.products[j];
          totalEarning +=
            singleProductObject.product.price * singleProductObject.quantity;
        }
      }

      let mobileEarnings = await fetchCategoryWiseProducts("Mobiles");
      let essentialsEarnings = await fetchCategoryWiseProducts("Essentials");
      let appliancesEarnings = await fetchCategoryWiseProducts("Appliances");
      let booksEarnings = await fetchCategoryWiseProducts("Books");
      let fashionEarnings = await fetchCategoryWiseProducts("Fashion");

      let earnings = {
        totalEarning,
        mobileEarnings,
        essentialsEarnings,
        appliancesEarnings,
        booksEarnings,
        fashionEarnings,
      };
      response.json(earnings);
    } catch (error) {
      response.status(500).json({ error: error.message });
    }
  }
);
async function fetchCategoryWiseProducts(category) {
  let earnings = 0;
  let categoryOrders = await Order.find({
    "products.product.category": category,
  });
  for (let i = 0; i < categoryOrders.length; i++) {
    let singleOrder = categoryOrders[i];
    for (let j = 0; j < singleOrder.products.length; j++) {
      let singleProductObject = singleOrder.products[j];
      if (singleProductObject.product.category == category) {
        earnings +=
          singleProductObject.product.price * singleProductObject.quantity;
      }
    }
  }
  return earnings;
}
module.exports = adminRouter;
