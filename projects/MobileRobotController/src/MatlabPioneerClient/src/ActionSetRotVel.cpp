//Author: Luis Felipe Posada
//Created: 02.07.2008
//
//Institute of Electrical Control Systems Engineering 
//Univerity of Dortmund
//
//Changelog:
//<DATE>    <AUTHOR>        <DESCRIPTION>

#include ".\actionsetrotvel.h"

ActionSetRotVel::ActionSetRotVel(double rotVelocity) :ArAction("rotVelocity"){
  myRotVelocity = rotVelocity;
}

ArActionDesired *ActionSetRotVel::fire(ArActionDesired currentDesired){
    myDesired.reset();
	myDesired.setRotVel(myRotVelocity);
	return &myDesired;
}