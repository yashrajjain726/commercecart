const express = require("express");
const authRouter = express.Router();
const bcryptjs = require("bcryptjs");
const User = require("../models/user");

// SIGN UP API
authRouter.post("/api/signup", async (request, response) => {
  try {
    const { name, email, password } = request.body;
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return response.status(400).json({ message: "Email exists in database" });
    }
    const encryptedPassword = await bcryptjs.hash(password, 8);
    let user = User({ name, email, password: encryptedPassword });
    user = await user.save();
    response.json(user);
  } catch (error) {
    response.status(500).json({ error: error.message });
  }
});

module.exports = authRouter;
