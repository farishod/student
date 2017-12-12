//Author: Luis Felipe Posada
//Created: 02.07.2008
//
//Institute of Electrical Control Systems Engineering 
//Univerity of Dortmund
//
//Changelog:
//<DATE>    <AUTHOR>        <DESCRIPTION>
#include ".\actionsetheading.h"

ActionSetHeading::ActionSetHeading(double heading) :ArAction("heading"){
  myHeading = heading;
}

ArActionDesired *ActionSetHeading::fire(ArActionDesired currentDesired){
    myDesired.reset();
	myDesired.setHeading(myHeading);
	return &myDesired;
}
