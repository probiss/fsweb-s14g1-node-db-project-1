const express = require("express");

const server = express();

server.use(express.json());

const whoIsThere = require("./accounts/accounts-router");

server.use("/api/accounts", whoIsThere);
server.get("/", (req, res) => {
    res.json({ message: "Yıkılmadım ,ayaktayım... Accountslarla başbaşayım..." });
});

module.exports = server;
