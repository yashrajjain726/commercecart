const jwt = require("jsonwebtoken");
const User = require("../models/user");
const admin = async (request, response, next) => {
  try {
    const token = request.headers("x-auth-token");
    if (!token)
      return response
        .status(401)
        .json({ message: "No authentication token found, access denied" });
    const isVerifiedToken = jwt.verify(token, "passwordKey");
    if (!isVerifiedToken)
      return response
        .status(401)
        .json({ message: "Token verification failed, authorization denied" });
    const user = await User.findById(isVerifiedToken.id);
    if (user.type == "user" || user.type == "seller")
      return response.status(401).json({ message: "You are not an admin" });
    request.user = isVerifiedToken.id;
    request.token = isVerifiedToken;
    next();
  } catch (error) {
    response.status(500).json({ error: error.message });
  }
};
