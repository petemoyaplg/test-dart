var express = require( 'express' );
const mongoose = require( 'mongoose' );
const cors = require( 'cors' );
const index = require( './routes' );



mongoose.connect( 'mongodb://localhost:27017/dyma_db' )
  .then( () => console.log( 'CONNEXION DB OK !' ) )
  .catch( () => console.log( 'ERROR DB' ) );



// mongoose
//   .connect(
//     // "mongodb+srv://admin:@cluster0-urpjt.gcp.mongodb.net/dymatrip?retryWrites=true&w=majority" // version web
//     "mongodb://localhost:27017/dyma_db"
//     // "mongodb+srv://jean:123@cluster0-urpjt.gcp.mongodb.net/dymatrip_emu?retryWrites=true&w=majority" // version avec emulateur
//   )
//   .then( () => console.log( 'CONNEXION DB OK !' ) );

var app = express();

app.use( express.json() );
app.use( express.urlencoded( { extended: false } ) );

app.use( index );
app.use( cors() );

// app.all( '*', ( req, res ) => {
//   res.send( 404 ).json( 'not-found' );
// } );

// //error handler
// app.use( function ( err, req, res, next ) {
//   //set locals, only providing error in development
//   res.locals.message = err.message;
//   res.locals.error = req.app.get( 'env' ) === 'development' ? err : {};

//   //render the page
//   res.status( err.status || 500 );
//   res.json( 'error' );
// } );

app.listen( 3000 );