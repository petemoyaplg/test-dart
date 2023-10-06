const express = require( 'express' );
const mongoose = require( 'mongoose' );
const cors = require( 'cors' );
const app = express();
const path = require( 'path' );
const City = require( './models/city.model' );
const Trip = require( './models/trip.model' );
const User = require( './models/user.model' );
const multer = require( 'multer' );
const bcrypt = require( "bcrypt" );
const jsonWebToken = require( 'jsonwebtoken' );
const { JWT_SECRET } = require( './config/jwt.js' );
const subpath = "/public/assets/images/activities";

const extractUser = require( './middlewares/extractUser.js' );
const moment = require( 'moment/moment' );

var storage = multer.diskStorage( {
  destination: function ( req, file, cb ) {
    cb( null, path.join( __dirname, subpath ) );
  }, filename: function ( req, file, cb ) {
    cb( null, file.originalname );
  }
} );

var upload = multer( { storage } );

app.use( cors() );
mongoose.set( 'debug', true );
mongoose
  .connect(
    // "mongodb+srv://admin:@cluster0-urpjt.gcp.mongodb.net/dymatrip?retryWrites=true&w=majority" // version web
    "mongodb://localhost:27017/dyma_db"
    // "mongodb+srv://jean:123@cluster0-urpjt.gcp.mongodb.net/dymatrip_emu?retryWrites=true&w=majority" // version avec emulateur
  )
  .then( () => console.log( 'connexion ok !' ) );

app.use( express.static( path.join( __dirname, 'public' ) ) );
app.use( express.json() );

// get cities
app.get( '/api/cities', async ( req, res ) => {
  try {
    const cities = await City.find( {} ).exec();
    res.json( cities );
  } catch ( e ) {
    res.status( 500 ).json( e );
  }
} );

// get trips
app.get( '/api/trips', async ( req, res ) => {
  try {
    const trips = await Trip.find( {} ).exec();
    res.json( trips );
  } catch ( e ) {
    res.status( 500 ).json( e );
  }
} );

// create trip
app.post( '/api/trip', async ( req, res ) => {
  try {
    const body = req.body;
    const trip = await new Trip( body ).save();
    res.json( trip );
  } catch ( e ) {
    res.status( 500 ).json( e );
  }
} );

// update trip
app.put( '/api/trip', async ( req, res ) => {
  try {
    const body = req.body;
    const trip = await Trip.findOneAndUpdate( { _id: body._id }, body, {
      new: true,
    } ).exec();
    res.json( trip );
  } catch ( e ) {
    res.status( 500 ).json( e );
  }
} );

// add activity to a city
app.post( '/api/city/:cityId/activity', async ( req, res ) => {
  try {
    const cityId = req.params.cityId;
    const activity = req.body;
    const city = await City.findOneAndUpdate(
      { _id: cityId },
      { $push: { activities: activity } },
      {
        new: true,
      }
    ).exec();
    res.json( city );
  } catch ( e ) {
    res.status( 500 ).json( e );
  }
} );

// verify uniqueness of a trip
app.get(
  '/api/city/:cityId/activities/verify/:activityName',
  async ( req, res ) => {
    const { cityId, activityName } = req.params;
    const city = await City.findById( cityId ).exec();
    const index = city.activities.findIndex(
      ( activity ) => activity.name === activityName
    );
    index === -1
      ? res.json( 'Ok' )
      : res.status( 400 ).json( 'L’activité existe déjà' );
  }
);

// upload activity image
app.post( "/api/activity/image", upload.single( 'activity' ), ( req, res, next ) => {
  try {
    const publicPath = `http://10.0.2.2/public/asset/images/activities/${ req.filter.originalname }`;
    res.json( publicPath || "error" );
  } catch ( e ) {
    next( e );
  }
} );

app.post( "/api/user", async ( req, res, next ) => {
  const body = req.body;
  try {
    await new User( {
      username: body.username,
      email: body.email,
      password: bcrypt.hashSync( body.password, 10 ),
    } ).save();
    res.status( 200 ).end();
  } catch ( e ) {
    console.log( e );
    next( e );
  }
} );

app.post( "/api/auth", async ( req, res, next ) => {
  const body = req.body;
  try {
    if ( !body.email || !body.password ) {
      res.status( 400 ).json( 'missing email or password' );
    } else {
      const user = await User.findOne( { email: body.email }, '-__v', {} ).exec();
      const match = await bcrypt.compare( body.password, user.password );
      if ( !match ) {
        res.status( 400 ).json( 'email ou mot de passe incorect' );
      } else {
        const token = jsonWebToken.sign(
          {
            sub: user._id.toString(),
          },
          JWT_SECRET,
          {
            expiresIn: '15min',
            algorithm: 'HS256'
          } );
        if ( !token ) {
          throw 'error token creation';
        } else {
          res.status( 200 ).json( { user, token } );
        }
      }
    }
  } catch ( e ) {
    next( e );
  }
} );

// http://10.0.2.2/api/user/current
app.get( "/api/user/current", extractUser, ( req, res ) => {
  res.status( 200 ).json( req.user );
} );

app.get( "api/auth/refresh-token", ( req, res, next ) => {
  try {
    const token = req.headers.authorization;
    if ( token ) {
      const jwtToken = token.split( ' ' )[ 1 ];
      const jwtTokenDecoded = jsonWebToken.verify( jwtToken, JWT_SECRET, { ignoreExpiration: true } );

      if ( jwtTokenDecoded && moment( jsonWebToken.exp * 1000 ) > moment().subtract( 7, 'd' ) ) {
        const userId = jwtTokenDecoded.sub;
        const newToken = jsonWebToken.sign(
          {
            sub: userId.toString(),
          },
          JWT_SECRET,
          {
            expiresIn: '15min',
            algorithm: 'HS256'
          } );
        if ( !newToken ) {
          throw 'error token creation';
        } else {
          res.status( 200 ).json( { token: newToken } );
        }
      } else {
        res.json( 400 ).json( 'token not valide or too old' );
      }
    } else {
      res.json( 400 ).json( 'no token' );
    }
  } catch ( error ) {
    next( e );
  }
} );


app.listen( 80 );
