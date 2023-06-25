const mongoose = require("mongoose");
const productSchema = mongoose.Schema({
  name: {
    typeof: String,
    required: true,
    trim: true,
  },
  description: {
    typeof: String,
    required: true,
    trim: true,
  },
  price: {
    typeof: Number,
    required: true,
  },
  quantity: {
    typeof: Number,
    required: true,
  },
  category: {
    typeof: String,
    required: true,
  },
  images: [{ type: String, required: true }],
});

const Product = mongoose.model("Product", productSchema);
module.exports = Product;
