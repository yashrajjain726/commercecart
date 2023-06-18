const jwt = require("jsonwebtoken");

const auth = async (request, response, next) => {
  try {
    const token = request.header("x-auth-token");
    if (!token)
      return response
        .status(401)
        .json({ message: "No authentication token found, access denied" });
    const isVerifiedToken = jwt.verify(token, "passwordKey");
    if (!isVerifiedToken)
      return response
        .status(401)
        .json({ message: "Token verification failed, authorization denied" });
    request.user = isVerifiedToken.id; // we will find user by id, so we are making request.user = id
    request.token = token;
    next();
  } catch (error) {
    response.status(500).json({ error: error.message });
  }
};

module.exports = auth;
