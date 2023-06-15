var mongoose = require("mongoose");

const userSchema = mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true,
  },
  email: {
    type: String,
    required: true,
    trim: true,
    validate: {
      validator: (value) => {
        const re =
          /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
        return value.match(re);
      },
    },
    message: "Please enter a valid email",
  },
  password: {
    type: String,
    required: true,
  },
  address: {
    default: "",
    type: String,
  },
  type: {
    type: String,
    default: "user",
  },
});
const User = mongoose.model("User", userSchema);
module.exports = User;
