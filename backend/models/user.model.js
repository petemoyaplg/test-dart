const mongoose = require( "mongoose" );
const Shema = mongoose.Schema;

const useShema = Shema( {
  email: { type: String, required: true },
  username: { type: String, required: true },
  password: { type: String, required: true },
} );

const User = mongoose.model( "user", useShema );

module.exports = User;