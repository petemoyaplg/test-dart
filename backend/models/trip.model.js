const mongoose = require( "mongoose" );
const schema = mongoose.Schema;
const activitySchema = require( "./activity.model" );

const tripSchema = schema( {
  city: { type: String, required: true },
  activities: [ activitySchema ],
  date: Date,
} );

const Trip = mongoose.model( "trip", tripSchema );

module.exports = Trip;
