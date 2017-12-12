//Author: Luis Felipe Posada
//Created: 02.07.2008
//
//Institute of Electrical Control Systems Engineering 
//Univerity of Dortmund
//
//Changelog:
//<DATE>    <AUTHOR>        <DESCRIPTION>

#include ".\ActionStopFront.h"

ActionStopFront::ActionStopFront(double stopDistance,double slowDistance, double slowSpeed) :ArAction("limiter Forward"){
  mySonar = NULL;
  myStopDistance = stopDistance;
  mySlowDistance = slowDistance;
  mySlowSpeed = slowSpeed;
}

void ActionStopFront::setRobot(ArRobot *robot)
{
  ArAction::setRobot(robot);
  mySonar = robot->findRangeDevice("sonar");
  if (robot == NULL)
    {
      ArLog::log(ArLog::Terse, "actionExample: ActionGo: Warning: I found no sonar, deactivating.");
      deactivate();
    }
}

ArActionDesired *ActionStopFront::fire(ArActionDesired currentDesired){
  double range;
  double speed;

  myDesired.reset();
  if (mySonar == NULL)
  {
    deactivate();
    myDesired.setVel(0);
  }
  // get the range of the sonar
  range = mySonar->currentReadingPolar(-45, 45) - myRobot->getRobotRadius();
  printf("%.0f\n", range);
  // if the range is greater than the stop distance, find some speed to go
  if (range > mySlowDistance)
  { 
	// do nothing
  }
  else if  (range > myStopDistance && range < mySlowDistance){
	speed = mySlowSpeed;	
    myDesired.setVel(speed);
  }
  else{
	myDesired.setVel(0);
  }
  // return a pointer to the actionDesired to the resolver to make our request
  return &myDesired;

}