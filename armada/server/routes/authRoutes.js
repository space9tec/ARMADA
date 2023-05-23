const express = require('express');
const authController = require('../controller/authController');
const cookieParser = require("cookie-parser");
const { userAuth } = require('../middleware/auth');


const router = express.Router();
router.use(cookieParser());
router.post('/register', authController.register);
router.post('/verify', authController.verifyOTP);
router.post('/login', authController.login);
// router.post('/refresh', authController.refreshToken);
router.get('/logout',userAuth, authController.logout);

module.exports = router;