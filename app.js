require('dotenv').config()
const fastify = require('fastify')({ logger: true })
const router = require('./routes/router')
const { MongoClient } = require('mongodb')

MongoClient.connect(process.env.MONGO_URL, (err, client) => {
    if (err) {
        console.error(err)
        process.exit(1)
    }
})
fastify.register(require('@fastify/cors'), {

    origin: '*',
    methods: ['GET', 'PUT', 'POST', 'DELETE', 'OPTIONS'],
    allowedHeaders: ['Content-Type', 'Authorization'],
    credentials: true

})

fastify.register(router, { prefix: process.env.API_PREFIX })


fastify.listen({ port: 3000, host: '127.0.0.1' }, (err, address) => {
    if (err) {
        fastify.log.error(err)
        process.exit(1)
    }
    fastify.log.info(`server listening on ${address}`)
})