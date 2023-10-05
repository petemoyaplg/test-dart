const mongoose = require( "mongoose" );
const Shema = mongoose.Schema;

const useShema = Shema( {
  email: String,
  usename: String,
  password: String
} );

const User = mongoose.model( "user", useShema );

module.exports = User;