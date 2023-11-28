const getAllUsers = require('../api/alluser')
const banuser = require('../api/ban')
const unban = require('../api/unban')

const router = async (fastify, options) => {
    fastify.get('/', async (request, reply) => {
        return { hello: 'world' }
    })
    fastify.post('/alluser', async (request, reply) => {
        return getAllUsers()
    })
    fastify.put('/ban', async (request, reply) => {
        return banuser(request, reply)
    })
    fastify.delete('/unban', async (request, reply) => {
        return unban(request, reply)
    })
}

module.exports = router

    