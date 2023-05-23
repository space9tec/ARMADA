const mongoose = require('mongoose');

const farmSchema = new mongoose.Schema({
    farm_name: {
      type: String,
      unique: true,
      required: true
    },
    owner_id: { 
        type: mongoose.Schema.Types.ObjectId, 
        ref: 'User', 
        required: true },
    farm_size: {
        type: Number, double: true,
        required: true
    },
    farm_image: {
      type: String
    },
    latitude: {
        type: Number, double: true,
      required: true
    },
    longitude: {
        type: Number, double: true,
        required: true
    },
    crops_grown: {
        type: String,
        required: true
    },
    soil_type: {
        type: String,
      required: true
      },
      deleted: {
        type: Boolean,
      default: false
      }
  },{
    timestamps: true // Add this option to include timestamps
  });

  module.exports = mongoose.model('Farm', farmSchema);