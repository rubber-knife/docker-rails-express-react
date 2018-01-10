const express         = require('express')
const server          = express()

const cors            = require('cors')
const bodyParser      = require('body-parser')
const compression     = require('compression')

server
  .use(cors())
  .use(bodyParser.json())
  .use(compression())
  .use(express.static(__dirname + '/public'))
  .use('/*', (req, res) => res.status(418).send('Oops'))

module.exports = server
