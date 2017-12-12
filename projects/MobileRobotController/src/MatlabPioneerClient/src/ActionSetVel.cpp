//Author: Luis Felipe Posada
//Created: 02.07.2008
//
//Institute of Electrical Control Systems Engineering 
//Univerity of Dortmund
//
//Changelog:
//<DATE>    <AUTHOR>        <DESCRIPTION>

#include ".\actionsetvel.h"

ActionSetVel::ActionSetVel(double velocity) :ArAction("velocity"){
  myVelocity = velocity;
}

ArActionDesired *ActionSetVel::fire(ArActionDesired currentDesired){
    myDesired.reset();
	myDesired.setVel(myVelocity);
	return &myDesired;
}