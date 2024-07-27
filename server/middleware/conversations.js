const path = require('path');
const db = require(path.join(__dirname, '../db.json'));

// Middleware pour gérer les requêtes de conversations
module.exports = (req, res, next) => {
  if (/conversations/.test(req.url) && req.method === 'GET') {
    const userId = req.query.senderId;
    const result = db.conversations.filter(
      conv => conv.senderId == userId || conv.recipientId == userId
    );

    res.status(200).json(result);
    return;
  }

  next();
};
