const router = require( "express" ).Router();
const User = require( "../models/user.models" );
const bcrypt = require( "bcrypt" );

router.post( "/", async ( req, res ) => {
  const body = req.body;
  try {
    await new User( {
      username: body.username,
      email: body.email,
      password: bcrypt.hashSync( body.password, 10 ),
    } ).save();
    res.status( 200 ).end();
  } catch ( error ) {
    next( e );
  }
} );

module.exports = router;