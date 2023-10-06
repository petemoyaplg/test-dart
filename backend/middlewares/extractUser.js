const { JWT_SECRET } = require( '../config/jwt.js' );
const jsonWebToken = require( 'jsonwebtoken' );
const User = require( '../models/user.model.js' );

module.exports = async ( req, next ) => {
  console.log( '====================================' );
  console.log( 'MIDDELWARE' );
  console.log( '====================================' );
  try {
    const token = req.headers.authorization;
    if ( token ) {
      const jwtToken = token.split( ' ' )[ 1 ];
      const jwtTokenDecoded = jsonWebToken.verify( jwtToken, JWT_SECRET );
      if ( jwtTokenDecoded ) {
        const userId = jwtTokenDecoded.sub;
        const user = await User.findOne(
          { _id: userId },
          '-__v -password',
          {} ).exec();
        req.user = user;
      }
    }
    next();
  } catch ( error ) {
    next( e );
  }
}