const PORT    = process.env.PORT || 3001
const server  = require('./server').listen(PORT)

server.on(
  'listening',
  () => console.log(`Express listening on port ${PORT}`)
)
