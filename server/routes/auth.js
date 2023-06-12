const express = require("express");
const authRouter = express.Router();

authRouter.post("/api/signup", (req, res) => {
  // GET DATA FROM CLIENT
  const { name, email, password } = req.body;
  // POST DATA IN DATABASE
  // RETURN DATA
});

module.exports = authRouter;
