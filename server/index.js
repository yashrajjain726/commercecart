// CREATING AN API

// IMPORTS FROM PACKAGES
const express = require("express");
const mongoose = require("mongoose");

// IMPORTS FROM FILES
const authRouter = require("./routes/auth");

// INITIALIZE
const PORT = 3000;
const app = express();
const DB =
  "mongodb+srv://admin:admin@cluster0.njlw8gx.mongodb.net/?retryWrites=true&w=majority";
// MIDDLEWARE
app.use(authRouter);

// CONNECTION
mongoose
  .connect(DB)
  .then(() => {
    console.log("Connection to the database has been established");
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, "0.0.0.0", function () {
  console.log(`CONNECTED AT PORT: ${PORT}`);
});
