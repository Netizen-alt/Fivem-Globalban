const mongodb = require('mongodb')

const unban = async (req, res) => {
    const { hex_id } = req.body
    console.log(hex_id);
    const client = await mongodb.MongoClient.connect(process.env.MONGO_URL)
    const db = client.db('s_globalban')
    const users = await db.collection('users')
    const user = await users.findOne({ hex_id: hex_id })
    if (user) {
        await users.deleteOne({ hex_id: hex_id })
        return { status: "success", message: "User unbanned" }
    } else {
        return { status: "error", message: "User not banned" }
    }
}

module.exports = unban