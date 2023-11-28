const mongodb = require('mongodb')
const fastify = require('fastify')
const getAllUsers = async (req, res) => {
    const client = await mongodb.MongoClient.connect(process.env.MONGO_URL)
    const db = client.db('s_globalban')
    const users = await db.collection('users').find().toArray()
    return users
}

module.exports = getAllUsers

