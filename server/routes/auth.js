const express = require("express");
const authRouter = express.Router();
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
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
authRouter.post("/api/signin", async (request, response) => {
  try {
    const { email, password } = request.body;
    const user = await User.findOne({ email });
    if (!user) {
      return response
        .status(400)
        .json({ message: "No user found in the database" });
    }
    const isPasswordMatched = await bcryptjs.compare(password, user.password);
    if (!isPasswordMatched) {
      return response
        .status(400)
        .status({ message: "Incorrect password, Please try again!" });
    }
    const token = jwt.sign({ id: user._id }, "passwordKey");
    response.json({ token, ...user._doc });
    // here we are passing token inside user,so that, when user signs in,
    // we will know from this token that, this is an jwt authenticated user.
    // {
    //  email:email,
    //  password:password
    //  token:token
    //  .. : ..
    // }

    response.json;
  } catch (error) {
    response.status(500).json({ error: error.message });
  }
});

module.exports = authRouter;
