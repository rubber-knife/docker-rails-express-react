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

module.exports = server
