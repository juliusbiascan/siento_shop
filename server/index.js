//MongoDB
//username : akr2803
//pwd      : rajput?283

// IMPORTS FROM PACKAGES
const express = require("express");
const mongoose = require("mongoose");

// IMPORTS FROM OTHER FILES
const authRouter = require("./routes/auth");
const adminRouter = require("./routes/admin");
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");

const PORT = process.env.PORT || 3000;
const app = express();
const DB =
    "mongodb+srv://siento-admin:DXURtSSD57Fk4WHb@cluster0.eligyhn.mongodb.net/?retryWrites=true&w=majority";

// middleware
// CLIENT -> middleware -> SERVER -> CLIENT

app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

// Connecting DB
mongoose
    .connect(DB)
    .then(() => {
        console.log("DB Connected Successfully");
    })
    .catch((e) => console.log(e));

//CREATING AN API
app.listen(PORT, "0.0.0.0", () => {
    console.log(`Listening at PORT ${PORT}`);
});

// GET, PUT, POST, DELETE, UPDATE -> CRUD
