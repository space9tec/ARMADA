const User = require('../models/user');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
require('dotenv').config();


const axios = require('axios');

// const apiSecret = "2546ff8bc7d4c24fc41f77eeefc7f3f72ea6fe21";
// Helper function to generate OTP
const generateOTP = () => {
    return Math.floor(100000 + Math.random() * 900000).toString().substring(0, 6);
};

//Helper function to send OTP
const sendOTP = async (phone, otp) => {
  let otpval = String(otp);
  let phonenumber = String(phone);
  console.log(phonenumber);
  const message = {
    secret: "2546ff8bc7d4c24fc41f77eeefc7f3f72ea6fe21",
    type: "sms",
    mode: "devices",
    device: "7e5f5e6d-c70d-4bf8-3577-460643830348",
    phone: phonenumber,
    message: `Your OTP is ${otpval}`
  };
  console.log(message);
  try {
    const response = await axios.post("https://hahu.io/api/send/otp", message);
    console.log(response.data);
  } catch (error) {
    console.error(error.response.data);
  }
};


// Registration
exports.register = async (req, res) => {
  try {

    const { first_name,last_name, password, phone , role } = req.body;
    const otp = generateOTP();
    const user = new User({ first_name,last_name, password, phone, otp ,role });
    console.log(user);
    await user.save();
    const maxAge = 10*60*60;
    await sendOTP(phone, otp);
    const token = jwt.sign({ userId: user._id }, process.env.JWT_TOKEN_SECRET,{ expiresIn: maxAge });
    
    res.cookie("jwt", token, {
      httpOnly: true,
      maxAge: maxAge * 1000, // 3hrs in ms
    });

    res.status(201).json({ message: 'User registered. OTP sent for verification.', Token: token });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

// OTP verification
exports.verifyOTP = async (req, res) => {
 try {
    const { phone, otp } = req.body;
    const user = await User.findOne({ phone });

    if (!user) {
      return res.status(404).json({ error: 'User not found.' });
    }

    if (user.otp === otp) {
      user.verified = true;
      user.otp = undefined;
      await user.save();
      res.status(200).json({ message: 'OTP verified. User is now verified.' });
    } else {
      res.status(400).json({ error: 'Invalid OTP.' });
    }
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

// Login
exports.login = async (req, res) => {
  try {
    const { phone, password } = req.body;
    const user = await User.findOne({ phone });

    if (!user) {
      return res.status(404).json({ error: 'User not found.' });
    }

    if (!user.verified) {
      return res.status(401).json({ error: 'User not verified. Please verify your OTP first.' });
    }

    const isPasswordValid = await user.comparePassword(password);

    if (!isPasswordValid) {
      return res.status(401).json({ error: 'Invalid password.' });
    }
    const maxAge = 10*60*60;
    // const accessToken = jwt.sign({ userId: user._id }, process.env.JWT_ACCESS_SECRET, );
    const token = jwt.sign({user}, process.env.JWT_TOKEN_SECRET,{ expiresIn: maxAge });
    
    // user.refreshTokens.push(refreshToken);
    // await user.save();
   
    res.cookie("jwt", token);
    res.status(200).json({message: 'Login Successful.', Token: token });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

// Logout
exports.logout = async (req, res) => {
  res.clearCookie('jwt');
  res.status(200).json({ message: 'Logged out successfully' });
};

// Reset password
exports.resetPassword = async(req, res) => {
    try {
      const { phone, otp, newPassword } = req.body;
      const user = await User.findOne({ phone });
  
      if (!user) {
        return res.status(404).json({ error: 'User not found.' });
      }
  
      if (user.otp !== otp) {
        return res.status(401).json({ error: 'Invalid OTP.' });
      }
  
      user.password = newPassword;
      user.otp = undefined;
      await user.save();
  
      res.status(200).json({ message: 'Password reset successful.' });
    } catch (error) {
      res.status(400).json({ error: error.message });
    }
  };

// Token refresh
// exports.refreshToken = async (req, res) => {
//   try {
//     const { refreshToken } = req.body;

//     if (!refreshToken) {
//       return res.status(401).json({ error: 'Refresh token is required.' });
//     }

//     jwt.verify(refreshToken, process.env.JWT_REFRESH_SECRET, async (err, payload) => {
//       if (err) {
//         return res.status(401).json({ error: 'Invalid refresh token.' });
//       }

//       const user = await User.findById(payload.userId);

//       if (!user || !user.refreshTokens.includes(refreshToken)) {
//         return res.status(401).json({ error: 'Invalid refresh token.' });
//       }

//       const newAccessToken = jwt.sign({ userId: user._id }, process.env.JWT_ACCESS_SECRET, { expiresIn: '15m' });
//       res.status(200).json({ accessToken: newAccessToken });
//     });
//   } catch (error) {
//     res.status(400).json({ error: error.message });
//   }
// };