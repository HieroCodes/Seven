const jsonServer = require('json-server');
const path = require('path');

const server = jsonServer.create();
const router = jsonServer.router(path.join(__dirname, 'db.json'));
const middlewares = jsonServer.defaults();

server.use(jsonServer.bodyParser);

// Middleware personnalisé
server.use(require('./middleware/conversations'));

// Routes personnalisées
server.use(jsonServer.rewriter({
  '/conversations/:id': '/conversations?senderId=:id',
  '/conversation/:id': '/conversations?id=:id',
  '/messages/:id': '/messages?conversationId=:id',
  '/message/:id': '/messages?id=:id',
  '/user/:id': '/users?id=:id'
}));

server.use(middlewares);
server.use(router);

server.post('/messages', (req, res) => {
  const db = router.db;
  const messages = db.get('messages');
  const newMessage = {
    ...req.body,
    id: messages.value().length ? messages.value().reduce((maxId, message) => Math.max(maxId, message.id), 0) + 1 : 1,
  };
  messages.push(newMessage).write();
  res.status(201).json(newMessage);
});

const PORT = process.env.PORT || 3000;
server.listen(PORT, () => {
  console.log(`JSON Server is running on port ${PORT}`);
});
