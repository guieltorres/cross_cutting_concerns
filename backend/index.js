const express = require("express")

const app = express()

app.get("/users", (req, res) => {
    res.json({
        name: "Gui"
    })
})

app.listen(6000, () => console.log("Running"))