const mongodb = require('mongodb')
const fastify = require('fastify')
const banuser = async (req, res) => {
    const { hex_id, discord_id, reason, servername } = req.body[0]

    const client = await mongodb.MongoClient.connect(process.env.MONGO_URL)
    const db = client.db('s_globalban')
    const users = await db.collection('users')
    const user = await users.findOne({ hex_id: hex_id })
    if (user) {
        return { status: "error", message: "User already banned" }
    } else {
        await users.insertOne({ hex_id: hex_id, discord_id: discord_id, reason: reason, servername: servername })
        return { status: "success", message: "User banned" }
    }
}

module.exports = banuser